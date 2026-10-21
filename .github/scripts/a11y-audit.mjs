#!/usr/bin/env node
// Accessibility audit of every page of the built documentation with axe-core
// (WCAG 2.0, 2.1 and 2.2, levels A and AA), in a real browser. Lighthouse only
// looks at a handful of pages; this covers all of them.
//
// Usage: node .github/scripts/a11y-audit.mjs <dir> [--report-only]
// where <dir> contains the build under score-docs/ (the site's baseurl).
// Exits 1 on any violation unless --report-only is given.
import { chromium } from "playwright"
import { AxeBuilder } from "@axe-core/playwright"
import { serve, pages, pool } from "./lib/site.mjs"

const root = process.argv[2] || "_site"
const reportOnly = process.argv.includes("--report-only")
const TAGS = ["wcag2a", "wcag2aa", "wcag21a", "wcag21aa", "wcag22aa"]

const site = await serve(root)
const browser = await chromium.launch()
const list = pages(root)
const byRule = new Map()

await pool(list, 4, async (p) => {
  const context = await browser.newContext()
  const page = await context.newPage()
  await page.route("**/*", (route) => {
    const u = new URL(route.request().url())
    return /^(127\.0\.0\.1|localhost)$/.test(u.hostname) ||
      !u.protocol.startsWith("http")
      ? route.continue()
      : route.abort()
  })
  await page.goto(site.url + p, {
    waitUntil: "domcontentloaded",
    timeout: 60000,
  })
  const { violations } = await new AxeBuilder({ page }).withTags(TAGS).analyze()
  for (const v of violations) {
    const entry = byRule.get(v.id) || {
      impact: v.impact,
      help: v.help,
      pages: new Map(),
    }
    entry.pages.set(p, v.nodes.map((n) => n.target.join(" ")).slice(0, 3))
    byRule.set(v.id, entry)
  }
  await context.close()
})

await browser.close()
site.close()

let total = 0
for (const [id, e] of [...byRule].sort()) {
  total += e.pages.size
  console.log(`\n${id} (${e.impact}): ${e.help} — ${e.pages.size} page(s)`)
  for (const [p, nodes] of [...e.pages].slice(0, 8))
    console.log(`  ${p}  ${nodes.join(" | ")}`)
  if (e.pages.size > 8) console.log(`  … and ${e.pages.size - 8} more`)
}
console.log(
  `\nAccessibility audit: ${list.length} pages, ${byRule.size} rule(s) violated`
)
process.exit(total && !reportOnly ? 1 : 0)
