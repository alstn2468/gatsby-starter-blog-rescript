%graphql(`
  query SiteMetadataQuery {
    site {
      siteMetadata {
        siteUrl
        title
        description
      }
    }
  }
`)

let useSiteMetadata = () => {
  let siteMetadataQueryResult: SiteMetadataQuery.Raw.t = Gatsby.useStaticQuery(
    SiteMetadataQuery.query,
  )
  let site = Js.Nullable.toOption(siteMetadataQueryResult.site)
  switch site {
  | None => Js.Exn.raiseError("Exception: site is not found!")
  | Some(result) => result.siteMetadata
  }
}
