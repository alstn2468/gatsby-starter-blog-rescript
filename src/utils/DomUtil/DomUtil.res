open Webapi.Dom
open DomRect

let getElements = selector => selector->Document.querySelectorAll(document)

let getElement = selector => selector->Document.querySelector(document)

let addClass = (element, className) => className->DomTokenList.add(element->Element.classList)

let removeClass = (element, className) => className->DomTokenList.remove(element->Element.classList)

let hasClass = (element, className) => className->DomTokenList.contains(element->Element.classList)

let getBody = () => {
  switch Global.document {
  | Some(document) => document["body"]
  | None => Js.Exn.raiseError("Exception: document.body is not found.")
  }
}

let addClassToBody = className => getBody()->addClass(className)

let removeClassToBody = className => getBody()->removeClass(className)

let hasClassOfBody = className => getBody()->hasClass(className)

let getRect = (className: string) => {
  switch getElement(className) {
  | Some(element) => Element.getBoundingClientRect(element)
  | None => Js.Exn.raiseError("Exception: element is not found!")
  }
}

let getPosY = (className: string) => className->getRect->y

let getDocumentHeight = () => {
  switch Global.document {
  | Some(document) => document["documentElement"]["offsetHeight"]
  | None => Js.Exn.raiseError("Exception: document.body is not found.")
  }
}
