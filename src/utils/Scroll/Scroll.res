open Webapi.Dom

let getElementFromRef = (ref: React.ref<Js.Nullable.t<'a>>) => {
  switch ref.current->Js.Nullable.toOption {
  | Some(element) => element
  | None => Js.Exn.raiseError("Exception: element is not found!")
  }
}

let scrollToTop = () => {
  if Global.scrollY > 340 {
    Global.scroll({"top": 0, "left": 0, "behavior": "smooth"})
  }
}

let scrollToLeft = %raw(`
  function (left, element) {
    element.scroll({left, top: 0, behavior: "smooth"})
  }
`)

let getTargetScrollX = (itemElement: Element.t, containerElement: Element.t) => {
  let itemWidth = itemElement->Element.unsafeAsHtmlElement->DomUtil.getOffsetWidthFromElement
  let itemLeft = itemElement->DomUtil.getLeftFromElement

  let containerElementScrollLeft =
    containerElement->Element.unsafeAsHtmlElement->DomUtil.getScrollLeftFromElement
  let containerElementWidth =
    containerElement->Element.unsafeAsHtmlElement->DomUtil.getOffsetWidthFromElement
  let containerElementLeft = containerElement->DomUtil.getLeftFromElement

  let refineLeft = itemLeft -. containerElementLeft

  containerElementScrollLeft +.
  refineLeft -.
  (containerElementWidth / 2 + itemWidth / 2)->Js.Int.toFloat
}

let scrollToCenterWithContainerRef = (
  containerRef: React.ref<Js.Nullable.t<'a>>,
  itemRef: React.ref<Js.Nullable.t<'a>>,
) => {
  let itemElement = getElementFromRef(itemRef)
  let containerElement = getElementFromRef(containerRef)

  itemElement->getTargetScrollX(containerElement)->scrollToLeft(containerElement)
}
