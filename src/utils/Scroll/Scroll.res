%%raw("import smoothScrollPolyfill from 'smoothscroll-polyfill'")
%%raw("import SmoothScroll from 'smooth-scroll/dist/smooth-scroll.min'")

let scroll = Js.Null.empty

let init = %raw(`
  function () {
    smoothScrollPolyfill.polyfill()
    scroll = new SmoothScroll(
      "a[href*=\"#\"]",
      { "speed": 500, "speedAsDuration": true },
    )
    return scroll
  }
`)

let destory = %raw(`
  function () {
    if (!scroll) {
      throw Error('Exception: SmoothScroll instance is not found.')
    }
    scroll.destory()
    scroll = null
    return scroll
  }
`)

let go = %raw(`
  function (dest) {
    if (!scroll) {
      throw Error('Exception: SmoothScroll instance is not found.')
    }
    scroll.animateScroll(dest)
    return scroll
  }
`)
