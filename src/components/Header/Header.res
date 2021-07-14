%%raw("import './index.scss'")

@val external __PATH_PREFIX__: string = "__PATH_PREFIX__"

@react.component
let make = (~title: string, ~pathname: string) => {
  let rootPath = __PATH_PREFIX__ ++ "/"
  let isRoot = pathname === rootPath
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
