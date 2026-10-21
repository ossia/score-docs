// Helpers shared by the browser checks: serve a built Jekyll site locally and list its pages.
import http from "node:http"
import fs from "node:fs"
import path from "node:path"

const TYPES = {
  ".html": "text/html; charset=utf-8",
  ".css": "text/css",
  ".js": "text/javascript",
  ".mjs": "text/javascript",
  ".json": "application/json",
  ".xml": "application/xml",
  ".svg": "image/svg+xml",
  ".png": "image/png",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".gif": "image/gif",
  ".webp": "image/webp",
  ".avif": "image/avif",
  ".woff2": "font/woff2",
  ".ico": "image/x-icon",
  ".mp4": "video/mp4",
  ".webm": "video/webm",
}

// Serve `root` on 127.0.0.1 (random port). Resolves to { url, close }.
export function serve(root) {
  root = path.resolve(root)
  const server = http.createServer((req, res) => {
    let p = decodeURIComponent(new URL(req.url, "http://x").pathname)
    let file = path.join(root, p)
    if (file !== root && !file.startsWith(root + path.sep)) {
      res.writeHead(403).end()
      return
    }
    if (fs.existsSync(file) && fs.statSync(file).isDirectory())
      file = path.join(file, "index.html")
    if (!fs.existsSync(file) && fs.existsSync(file + ".html")) file += ".html"
    if (!fs.existsSync(file)) {
      res.writeHead(404).end("not found")
      return
    }
    res.writeHead(200, {
      "Content-Type":
        TYPES[path.extname(file).toLowerCase()] || "application/octet-stream",
    })
    fs.createReadStream(file).pipe(res)
  })
  return new Promise((resolve) =>
    server.listen(0, "127.0.0.1", () =>
      resolve({
        url: `http://127.0.0.1:${server.address().port}`,
        close: () => server.close(),
      })
    )
  )
}

// Every HTML page of the built site, as URL paths ("/", "/score/download.html", ...).
// Redirect stubs (meta refresh only) are skipped.
export function pages(root) {
  const out = []
  const walk = (dir) => {
    for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
      const f = path.join(dir, e.name)
      if (e.isDirectory()) walk(f)
      else if (e.name.endsWith(".html")) {
        const head = fs.readFileSync(f, "utf8").slice(0, 600)
        if (/http-equiv="refresh"/i.test(head)) continue
        let p = "/" + path.relative(root, f).split(path.sep).join("/")
        p = p.replace(/(^|\/)index\.html$/, "$1")
        out.push(p)
      }
    }
  }
  walk(root)
  return out.sort()
}

// Run `fn(item)` over `items` with at most `n` in flight.
export async function pool(items, n, fn) {
  const results = []
  let i = 0
  await Promise.all(
    Array.from({ length: Math.min(n, items.length) }, async () => {
      while (i < items.length) {
        const k = i++
        results[k] = await fn(items[k])
      }
    })
  )
  return results
}
