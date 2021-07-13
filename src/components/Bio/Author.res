@react.component
let make = (~author: Js.Nullable.t<string>) => {
  switch Js.Nullable.toOption(author) {
  | Some(author) =>
    <div className="author-name-content"> <span> {React.string(`@${author}`)} </span> </div>
  | None => React.null
  }
}
let default = make
