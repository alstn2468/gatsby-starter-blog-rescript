let getTheme = (checked: bool) => checked ? #DARK : #LIGHT

let isDarkMode = theme => theme === #DARK

let getBoolFromBoolString = (value: string) => value === "true"

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
  Storage.setValueToLocalStorage(localStorageThemeKey, value |> Js.String.make)

  value
}

let useThemeEffect = (handleChange: bool => unit) => {
  React.useEffect0(() => {
    if %raw(`typeof window !== undefined`) {
      DomUtil.hasClassOfBody("dark")
      |> Js.String.make
      |> getThemeFromLocalStorage
      |> Js.String.make
      |> getBoolFromBoolString
      |> handleChange
    }

    None
  })
}
