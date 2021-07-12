%%raw("import './index.scss'")

@react.component
let make = (~title: string, ~pathname: string) => {
  let isRoot = pathname == ""
  <>
    <header className="top">
      {switch isRoot {
      | true => <Gatsby.Link _to="/"> {React.string(title)} </Gatsby.Link>
      | false => React.null
      }}
      <GithubIcon />
    </header>
    <div className="top-border-bottom" />
  </>
}

let default = make
