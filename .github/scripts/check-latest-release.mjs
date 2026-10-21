#!/usr/bin/env node
// Are the docs on the latest release? The release archive (_data/releases.json)
// is kept up to date by the "Synchronize release archive" workflow; this check
// fails when that sync stopped and the latest ossia/score release is missing.
// Uses GITHUB_TOKEN when set (higher API rate limit).
import fs from "node:fs"

const archive = JSON.parse(fs.readFileSync("_data/releases.json", "utf8"))
const tags = new Set(archive.releases.map((r) => r.tag_name))

const headers = { Accept: "application/vnd.github+json" }
if (process.env.GITHUB_TOKEN)
  headers.Authorization = `Bearer ${process.env.GITHUB_TOKEN}`
const res = await fetch(
  "https://api.github.com/repos/ossia/score/releases/latest",
  { headers }
)
if (!res.ok) throw new Error(`GitHub API answered ${res.status}`)
const latest = (await res.json()).tag_name

const ok = tags.has(latest)
console.log(
  `${ok ? "OK    " : "BEHIND"} ossia/score latest release ${latest} ${ok ? "is" : "is not"} in _data/releases.json`
)
process.exit(ok ? 0 : 1)
