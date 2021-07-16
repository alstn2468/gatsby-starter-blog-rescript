let adjustScroll = (destPos: int) => {
  if Global.scrollY > destPos {
    Global.scroll({"top": destPos, "left": 0, "behavior": "smooth"})
  }
}

let scrollToCenter = %raw(`
  function (element) {
    element.current?.scrollIntoView({
      behavior: "smooth",
      block: "nearest",
      inline: "center"
    })
  }
`)
