type t = [#DARK | #LIGHT]

let getTheme = (checked: bool) => checked ? #DARK : #LIGHT

let isDarkMode = theme => theme === #DARK

let getBoolFromBoolString = (value: string) => value === "true"

let usePreferDarkMode = () => Media.useMedia(["(prefers-color-scheme: dark)"], ["true"], "false")

let addDarkThemeClassToBody = () => {
  DomUtil.addClassToBody("dark")
  DomUtil.removeClassToBody("light")
}

let addLightThemeClassToBody = () => {
  DomUtil.addClassToBody("light")
  DomUtil.removeClassToBody("dark")
}

let toggleTheme = isDarkMode => {
  switch isDarkMode {
  | true => addDarkThemeClassToBody()
  | false => addLightThemeClassToBody()
  }
  isDarkMode
}

let localStorageThemeKey = `${Constant.localStorageKey}/theme`

let getThemeFromLocalStorage = (defaultValue: string) => {
  let value = Storage.getValueFromLocalStorage(localStorageThemeKey)
  switch Js.Json.test(value, Js.Json.Null) {
  | false => value
  | true => Js.Json.string(defaultValue)
  }
}

let setThemeToLocalStorage = (value: bool) => {
  localStorageThemeKey->Storage.setValueToLocalStorage(value->Js.String.make)

  value
}

let useThemeEffect = (handleChange: bool => unit) => {
  React.useEffect0(() => {
    switch Global.window {
    | Some(_) =>
      usePreferDarkMode()
      ->getThemeFromLocalStorage
      ->Js.String.make
      ->getBoolFromBoolString
      ->handleChange
    | None => ()
    }

    None
  })
}
