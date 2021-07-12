%%raw("import './index.scss'")

@react.component
let make = () => {
  let (checked, setChecked) = React.useState(_ => false)
  let toggleChecked = () => setChecked(checked => !checked)
  let handleChange = (checked: bool) => {
    checked->Theme.getTheme->Theme.toggleTheme->toggleChecked
  }
  <div className="switch-container">
    <label htmlFor="normal-switch">
      <ReactSwitch
        onChange={handleChange}
        checked={checked}
        id="normal-switch"
        height={24}
        width={48}
        checkedIcon={<div className="icon checkedIcon"> {React.string("D")} </div>}
        uncheckedIcon={<div className="icon uncheckedIcon"> {React.string("L")} </div>}
        offColor="#d9dfe2"
        offHandleColor="#fff"
        onColor="#999"
        onHandleColor="#282c35"
      />
    </label>
  </div>
}

let default = make
