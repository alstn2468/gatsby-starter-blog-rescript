let adjustScroll = (destPos: int) => {
  if Global.scrollY > destPos {
    Global.scroll({"top": destPos, "left": 0, "behavior": "smooth"})
  }
}

let scrollToLeft = %raw(`
  function (element, left) {
    element.scroll({left, top: 0, behavior: "smooth"})
  }
`)
