open Webapi.Dom
open DomRect

@val external baseDocument: 'a = "document"

let getElements = (selector) => document |> Document.querySelectorAll(selector)

let getElement = (selector) => document |> Document.querySelector(selector)

let addClass = (element, className) =>
  element |> Element.classList |> DomTokenList.add(className)

let removeClass = (element, className) =>
  element |> Element.classList |> DomTokenList.remove(className)

let hasClass = (element, className) =>
  element |> Element.classList |> DomTokenList.contains(className)

let getBody = () => baseDocument["body"]

let addClassToBody = (className) => addClass(getBody(), className)

let removeClassToBody = (className) => removeClass(getBody(), className)

let hasClassOfBody = (className) => hasClass(getBody(), className)

let getRect = (className) => {
  switch getElement(className) {
  | Some(element) => Element.getBoundingClientRect(element)
  | None => Js.Exn.raiseError("Exception: element is not found!")
  }
}

let getPosY = (className) => {
  getRect(className) |> y
}

let getDocumentHeight = () => {
  baseDocument["documentElement"]["offsetHeight"]
}
