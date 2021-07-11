let getValueFromNullable = (value: Js.nullable<'a>, defaultValue: 'a) => {
  switch Js.Nullable.toOption(value) {
  | None => defaultValue
  | Some(value) => value
  }
}
