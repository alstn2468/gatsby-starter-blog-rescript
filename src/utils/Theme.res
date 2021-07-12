let getTheme = (checked: bool) => checked ? #DARK : #LIGHT

let addDarkThemeClassToBody = () => {
  DomUtil.addClassToBody("dark");
  DomUtil.removeClassToBody("light");
}

let addLightThemeClassToBody = () => {
  DomUtil.addClassToBody("light");
  DomUtil.removeClassToBody("dark");
}

let toggleTheme = (theme) => {
  switch theme {
  | #DARK => addDarkThemeClassToBody()
  | #LIGHT => addLightThemeClassToBody()
  }
}
