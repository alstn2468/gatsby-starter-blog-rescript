@module("react-switch") @react.component
external make: (
  ~id: string,
  ~height: int,
  ~width: int,
  ~checked: bool,
  ~checkedIcon: React.element,
  ~uncheckedIcon: React.element,
  ~onChange: bool => unit,
  ~offColor: string,
  ~offHandleColor: string,
  ~onColor: string,
  ~onHandleColor: string,
) => React.element = "default"
