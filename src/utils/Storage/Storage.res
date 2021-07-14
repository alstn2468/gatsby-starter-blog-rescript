@val @scope("window")
external localStorage: 'a = "localStorage"

@val @scope("window")
external sessionStorage: 'a = "sessionStorage"

@val @scope(("window", "localStorage"))
external localStorageGetItem: string => option<string> = "getItem"

@val @scope(("window", "localStorage"))
external localStorageSetItem: (string, string) => unit = "setItem"

let isLocalStorageEmpty = localStorage => {
  switch (Js.Nullable.toOption(Global.window), localStorage === Js.Obj.empty()) {
  | (Some(_), false) => false
  | (_, _) => true
  }
}

let getValueFromLocalStorage = (key: string) => {
  switch localStorageGetItem(key) {
  | Some(value) => Js.Json.parseExn(value)
  | None => Js.Json.null
  }
}

let setValueToLocalStorage = (key: string, data: string) => {
  switch isLocalStorageEmpty(localStorage) {
  | true => ()
  | false => localStorageSetItem(key, data)
  }
}
