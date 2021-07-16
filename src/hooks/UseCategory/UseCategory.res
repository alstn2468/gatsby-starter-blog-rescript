open Global

let useCategory = () => {
  let (category, setCategory) = React.useState(_ => "All")

  let selectCategory = category => {
    let queryString = QueryString.stringify({"category": category})
    setCategory(_ => category)->Scroll.scrollToTop
    historyPushState({"category": category}, "", `${pathname}?${queryString}`)
  }

  let changeCategory = () => {
    let category = switch QueryString.parse(search)["categroy"] {
    | Some(category) => category
    | None => "All"
    }
    setCategory(_ => category)
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
    changeCategory()

    None
  })

  (category, selectCategory)
}
