%%raw("import './index.scss'")

@react.component
let make = (
  ~categories: array<string>,
  ~selectedCategory: string,
  ~selectCategory: string => unit,
) => {
  let ulElementRef = React.useRef(Js.Nullable.null)
  let scrollToCenter = (tabRef: React.ref<Js.Nullable.t<'a>>) => {
    let getElementFromRef = (ref: React.ref<Js.Nullable.t<'a>>) => {
      switch ref.current->Js.Nullable.toOption {
      | Some(element) => element
      | None => Js.Exn.raiseError("Exception: element is not found!")
      }
    }

    let tabElement = getElementFromRef(tabRef)
    let tabWidth =
      tabElement->Webapi.Dom.Element.unsafeAsHtmlElement->DomUtil.getOffsetWidthFromElement
    let tabLeft = tabElement->DomUtil.getLeftFromElement

    let ulElement = getElementFromRef(ulElementRef)
    let ulElementScrollLeft =
      ulElement->Webapi.Dom.Element.unsafeAsHtmlElement->DomUtil.getScrollLeftFromElement
    let ulElementWidth =
      ulElement->Webapi.Dom.Element.unsafeAsHtmlElement->DomUtil.getOffsetWidthFromElement
    let ulElementLeft = ulElement->DomUtil.getLeftFromElement

    let refineLeft = tabLeft -. ulElementLeft
    let targetScollX =
      ulElementScrollLeft +. refineLeft -. (ulElementWidth / 2 + tabWidth / 2)->Js.Int.toFloat

    DomUtil.scrollToLeft(ulElement, targetScollX)
  }

  let renderCategoryItem = (title: string) => {
    <CategoryItem
      key={`category-${title}`} title scrollToCenter selectedCategory onClick={selectCategory}
    />
  }

  <ul
    ref={ReactDOM.Ref.domRef(ulElementRef)}
    className="category-container"
    role="tablist"
    id="category">
    <CategoryItem title={"All"} onClick={selectCategory} selectedCategory scrollToCenter />
    {categories->Js.Array2.map(renderCategoryItem)->React.array}
  </ul>
}

let default = make
