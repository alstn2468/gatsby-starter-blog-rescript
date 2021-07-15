open Webapi.Dom
open DomRect

let getElements = selector => selector->Document.querySelectorAll(document)

let getElement = selector => selector->Document.querySelector(document)

let addClass = (element, className) => className->DomTokenList.add(element->Element.classList)

let removeClass = (element, className) => className->DomTokenList.remove(element->Element.classList)

let hasClass = (element, className) => className->DomTokenList.contains(element->Element.classList)

let getBody = () => Global.document["body"]

let addClassToBody = className => getBody()->addClass(className)

let removeClassToBody = className => getBody()->removeClass(className)

let hasClassOfBody = className => getBody()->hasClass(className)

let getRect = (className: string) => {
  switch getElement(className) {
  | Some(element) => Element.getBoundingClientRect(element)
  | None => Js.Exn.raiseError("Exception: element is not found!")
  }
}

let getRectFromElement = element => {
  element->Element.getBoundingClientRect
}

let getLeftFromElement = element => {
  element->getRectFromElement->left
}

let getOffsetWidthFromElement = element => {
  element->HtmlElement.offsetWidth
}

let getScrollLeftFromElement = element => {
  element->HtmlElement.scrollLeft
}

let scrollToLeft = %raw(`
  function (element, left) {
    element.scroll({left, top: 0, behavior: "smooth"})
  }
`)

let getPosY = (className: string) => className->getRect->y

let getDocumentHeight = () => Global.document["documentElement"]["offsetHeight"]
