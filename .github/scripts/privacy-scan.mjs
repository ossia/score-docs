#!/usr/bin/env node
// Privacy check for the built documentation. The ossia.io privacy policy
// promises that nothing is loaded from, or sent to, a third party before the
// visitor accepts the cookie banner, and that no cookie is set. That promise
// is only as good as the last embed someone added, so every page is opened in
// a real browser as a new visitor: no request may leave the site, and no
// cookie may be set.
//
// The banner and the analytics loader come from the main site (/js/consent.js,
// /js/consent-head.js), which a docs build does not contain: they are checked
// by the ossia.github.io privacy scan, not here.
//
// External requests are recorded, then aborted, so the result does not depend
// on the network. Usage: node .github/scripts/privacy-scan.mjs <dir>
// where <dir> contains the build under score-docs/ (the site's baseurl).
import { chromium } from "playwright"
import { serve, pages, pool } from "./lib/site.mjs"

const root = process.argv[2] || "_site"

// The docs are served from ossia.io/score-docs/: absolute links to ossia.io
// (the theme's logo URL, for instance) are the site's own origin, not a third party.
const FIRST_PARTY = /(^|\.)ossia\.io$/

const isLocal = (u) => {
  if (!/^https?:/.test(u)) return true // data:, blob:, about:
  const h = new URL(u).hostname
  return h === "127.0.0.1" || h === "localhost"
}

async function visit(browser, url) {
  const context = await browser.newContext()
  const page = await context.newPage()
  const external = new Set()
  await page.route("**/*", (route) => {
    const u = route.request().url()
    if (isLocal(u)) return route.continue()
    const host = new URL(u).hostname
    if (!FIRST_PARTY.test(host)) external.add(host)
    return route.abort()
  })
  try {
    await page.goto(url, { waitUntil: "domcontentloaded", timeout: 60000 })
    // Lazy content (images, players behind facades) appears on scroll
    await page.evaluate(async () => {
      for (let y = 0; y < document.body.scrollHeight; y += 800) {
        window.scrollTo(0, y)
        await new Promise((r) => setTimeout(r, 40))
      }
    })
    await page.waitForTimeout(500)
  } catch (e) {
    external.add(`(page did not load: ${e.message.split("\n")[0]})`)
  }
  const cookies = (await context.cookies()).map((c) => c.name)
  await context.close()
  return { external: [...external], cookies }
}

const site = await serve(root)
const browser = await chromium.launch()
const list = pages(root)
const problems = []

await pool(list, 4, async (p) => {
  const r = await visit(browser, site.url + p)
  if (r.external.length)
    problems.push(`${p}: contacts ${r.external.join(", ")} before consent`)
  if (r.cookies.length)
    problems.push(`${p}: sets cookies ${r.cookies.join(", ")} before consent`)
})

await browser.close()
site.close()

console.log(`Privacy scan: ${list.length} pages, ${problems.length} problem(s)`)
for (const m of problems.sort()) console.log("  - " + m)
process.exit(problems.length ? 1 : 0)
