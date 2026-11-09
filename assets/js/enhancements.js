// Page enhancements:
// - YouTube and Vimeo embeds only load the player when clicked: the player
//   waits in an inert <template> next to a .video-facade button, so nothing
//   contacts the video site before the visitor presses play;
// - code blocks that scroll horizontally can be scrolled with the keyboard.
;(() => {
  "use strict"
  document.querySelectorAll("pre").forEach((pre) => {
    if (pre.scrollWidth > pre.clientWidth) pre.tabIndex = 0
  })
  document.querySelectorAll(".video-facade").forEach((btn) => {
    btn.addEventListener("click", () => {
      const tpl = btn.nextElementSibling
      if (!tpl || tpl.tagName !== "TEMPLATE") return
      const iframe = tpl.content.querySelector("iframe").cloneNode(true)
      const src = iframe.getAttribute("src")
      iframe.setAttribute(
        "src",
        src + (src.indexOf("?") < 0 ? "?" : "&") + "autoplay=1"
      )
      tpl.remove()
      btn.replaceWith(iframe)
    })
  })
})()
