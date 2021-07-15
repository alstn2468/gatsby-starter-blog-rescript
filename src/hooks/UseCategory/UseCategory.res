let destPos = 340

let adjustScroll = () => {
  if Global.window["scrollY"] > destPos {
    Scroll.go(destPos)
  }
}

let useCategory = () => {
  let (category, setCategory) = React.useState(_ => "All")

  let selectCategory = category => {
    let pathName = Global.window["location"]["pathname"]
    let queryString = QueryString.stringify({ "category": category })
    setCategory(_ => category)
    adjustScroll()
    Global.window["history"]["pushState"](.{"category": category}, "", `${pathName}?${queryString}`)
  }

  let changeCategory = (withScroll: option<bool>) => {
    let search = Global.window["location"]["search"]
    let category = switch QueryString.parse(search)["categroy"] {
      | Some(category) => category
      | None => "All"
    }
    setCategory(_ => category)
    switch withScroll {
    | Some(_) => adjustScroll()
    | None => ()
    }
  }

  React.useEffect0(() => {
    Scroll.init();

    Some(() => {
      Scroll.destory()
    });
  })

  React.useEffect0(() => {
    Global.window["addEventListener"]("popstate", changeCategory)

    Some(() => {
      Global.window["removeEventListener"]("popstate", changeCategory)
    })
  })

  React.useEffect0(() => {
    changeCategory(Some(false))

    None
  })

  (category, selectCategory)
}
