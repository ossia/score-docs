// ESLint for the JavaScript we write. The just-the-docs theme script, vendored
// libraries, the built site and the score scripts (run inside ossia score) are ignored.
import js from "@eslint/js"
import globals from "globals"

export default [
  {
    ignores: [
      "_site/**",
      ".claude/**",
      "node_modules/**",
      "vendor/**",
      "assets/js/vendor/**",
      "assets/js/just-the-docs.js",
      "assets/js/zzzz-search-data.json",
      "assets/scores/**",
      "script/**",
      "tools/**",
      "_includes/**",
    ],
  },
  js.configs.recommended,
  {
    // Scripts loaded by the pages, as classic (non-module) scripts
    files: ["assets/js/**/*.js"],
    languageOptions: {
      sourceType: "script",
      ecmaVersion: 2020,
      globals: { ...globals.browser },
    },
  },
  {
    // Node scripts; callbacks passed to page.evaluate() run in the browser
    files: [".github/**/*.mjs", "eslint.config.mjs"],
    languageOptions: {
      sourceType: "module",
      globals: { ...globals.node, ...globals.browser },
    },
  },
]
