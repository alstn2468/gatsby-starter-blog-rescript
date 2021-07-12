%%raw("import './index.scss'")

@react.component
let make = (~title: string, ~pathname: string) => {
  let rootPath = Constant.__PATH_PREFIX__ ++ "/"
  let isRoot = pathname !== rootPath
  <>
    <header className="top">
      {switch isRoot {
      | true => React.null
      | false => <Gatsby.Link _to="/" className="link"> {React.string(title)} </Gatsby.Link>
      }}
      <GithubIcon />
    </header>
    <div className="top-border-bottom" />
  </>
}

let default = make
