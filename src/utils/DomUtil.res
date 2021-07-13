open Webapi.Dom
open DomRect

@val external baseDocument: 'a = "document"

let getElements = selector => document |> Document.querySelectorAll(selector)

let getElement = selector => document |> Document.querySelector(selector)

let addClass = (element, className: string) =>
  element |> Element.classList |> DomTokenList.add(className)

let removeClass = (element, className: string) =>
  element |> Element.classList |> DomTokenList.remove(className)

let hasClass = (element, className: string) =>
  element |> Element.classList |> DomTokenList.contains(className)

let getBody = () => baseDocument["body"]

let addClassToBody = (className: string) => addClass(getBody(), className)

let removeClassToBody = (className: string) => removeClass(getBody(), className)

let hasClassOfBody = (className: string) => hasClass(getBody(), className)

let getRect = (className: string) => {
  switch getElement(className) {
  | Some(element) => Element.getBoundingClientRect(element)
  | None => Js.Exn.raiseError("Exception: element is not found!")
  }
}

let getPosY = (className: string) => {
  getRect(className) |> y
}

let getDocumentHeight = () => {
  baseDocument["documentElement"]["offsetHeight"]
}
