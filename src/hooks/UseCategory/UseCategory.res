open Global

// TODO: element 기준으로 변경 및 scrollIntoView 사용
let destPos = 340

let useCategory = () => {
  let (category, setCategory) = React.useState(_ => "All")

  let selectCategory = category => {
    let queryString = QueryString.stringify({"category": category})
    setCategory(_ => category)
    Scroll.adjustScroll(destPos)
    historyPushState({"category": category}, "", `${pathname}?${queryString}`)
  }

  let changeCategory = (withScroll: option<bool>) => {
    let category = switch QueryString.parse(search)["categroy"] {
    | Some(category) => category
    | None => "All"
    }
    setCategory(_ => category)
    switch withScroll {
    | Some(_) => Scroll.adjustScroll(destPos)
    | None => ()
    }
  }

  React.useEffect0(() => {
    addEventListener("popstate", changeCategory)

    Some(
      () => {
        removieEventListener("popstate", changeCategory)
      },
    )
  })

  React.useEffect0(() => {
    changeCategory(Some(false))

    None
  })

  (category, selectCategory)
}
