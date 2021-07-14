%%raw("import './index.scss'")

@react.component
let make = (~title: string) => {
  <h1 className="home-header"> {React.string(title)} </h1>
}

let default = make
