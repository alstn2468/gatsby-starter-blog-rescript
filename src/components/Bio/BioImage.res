open GatsbyImage.Fragments

%graphql(`
  query BioImageQuery {
    avatar: file(absolutePath: { regex: "/profile.png/" }) {
      childImageSharp {
        fixed(width: 72, height: 72) {
          ...GatsbyImageSharpFixed
        }
      }
    }
  }
`)

@react.component
let make = (~author: Js.Nullable.t<string>) => {
  let bioImageQueryResult: BioImageQuery.Raw.t = Gatsby.useStaticQuery(BioImageQuery.query)
  let author = switch Js.Nullable.toOption(author) {
  | Some(author) => author
  | None => "profile.png"
  }
  switch Js.Nullable.toOption(bioImageQueryResult.avatar) {
  | Some(avatar) =>
    switch Js.Nullable.toOption(avatar.childImageSharp) {
    | Some(childImageSharp) =>
      switch Js.Nullable.toOption(childImageSharp.fixed) {
      | Some(fixed) => <GatsbyImage fixed alt={author} className="author-image" />
      }
    }
  | None => React.null
  }
}

let default = make
