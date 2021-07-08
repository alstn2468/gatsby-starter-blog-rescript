@module("gatsby")
external useStaticQuery: string => Js.Json.t = "useStaticQuery"

module Link = {
  @module("gatsby") @react.component
  external make: (
    ~children: React.element,
    ~_to: string,
    ~className: string=?,
    ~style: ReactDOM.Style.t=?,
    ~replace: bool=?,
    ~onClick: ReactEvent.Mouse.t => unit=?,
    ~state: Js.Json.t=?,
    ~activeClassName: string=?,
    ~activeStyle: ReactDOM.Style.t=?,
    ~partiallyActive: bool=?,
    ~rel: string=?,
  ) => React.element = "Link"
}

type location = {
  key: string,
  pathname: string,
  search: string,
  hash: string,
  state: option<Js.Json.t>,
}

type navigationOptions = {
  state: option<Js.Json.t>,
  replace: bool,
}

@module("@reach/router") external navigate: string => unit = "navigate"
@module("@reach/router") external navigateWithOpts: (string, navigationOptions) => unit = "navigate"
