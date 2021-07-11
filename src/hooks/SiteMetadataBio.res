%graphql(`
  query SiteMetadataBioQuery {
    site {
      siteMetadata {
        author
        introduction
        social {
          twitter
          github
          instagram
          facebook
        }
      }
    }
  }
`)

let useSiteMetadataBio = () => {
  let siteMetadataQueryResult: SiteMetadataBioQuery.Raw.t = Gatsby.useStaticQuery(
    SiteMetadataBioQuery.query,
  )
  let site = Js.Nullable.toOption(siteMetadataQueryResult.site)
  switch site {
  | None => Js.Exn.raiseError("Exception: site is not found!")
  | Some(result) => result.siteMetadata
  }
}
