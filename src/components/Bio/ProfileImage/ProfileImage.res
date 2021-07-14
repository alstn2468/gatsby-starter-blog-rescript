open GatsbyImage.Fragments

%graphql(`
  query ProfileImageQuery {
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
  let profileImageQueryResult: ProfileImageQuery.Raw.t = Gatsby.useStaticQuery(
    ProfileImageQuery.query,
  )
  let author = switch Js.Nullable.toOption(author) {
  | Some(author) => author
  | None => "profile.png"
  }
  switch Js.Nullable.toOption(profileImageQueryResult.avatar) {
  | Some(avatar) =>
    switch Js.Nullable.toOption(avatar.childImageSharp) {
    | Some(childImageSharp) =>
      switch Js.Nullable.toOption(childImageSharp.fixed) {
      | Some(fixed) => <GatsbyImage fixed alt={author} className="author-image" />
      | None => React.null
      }
    | None => React.null
    }
  | None => React.null
  }
}

let default = make
