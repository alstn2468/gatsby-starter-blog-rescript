@val external window: 'a = "window"

let localStorage = %raw(`typeof window !== undefined ? window.localStorage : {}`)
let sessionStorage = %raw(`typeof window !== undefined ? window.sessionStorage : {}`)

let isLocalStorageEmpty = localStorage => %raw(`!window`) || localStorage === Js.Obj.empty()

let getValueFromLocalStorage = (key: string) => {
  switch Js.Nullable.toOption(%raw(`localStorage.getItem(key)`)) {
  | Some(value) => Js.Json.parseExn(value)
  | None => Js.Json.null
  }
}

let setValueToLocalStorage = (key: string, data: 'a) => {
  switch isLocalStorageEmpty(localStorage) {
  | true => ()
  | false => %raw(`localStorage.setItem(key, data)`)
  }
}
