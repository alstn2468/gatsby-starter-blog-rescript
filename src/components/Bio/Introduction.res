  @react.component
  let make = (~introduction: Js.Nullable.t<string>) => {
    switch Js.Nullable.toOption(introduction) {
    | Some(introduction) =>
      <div className="author-introduction"> {React.string(introduction)} </div>
    | None => React.null
    }
  }

  let default = make;
