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

// https://github.com/gatsbyjs/gatsby/issues/25406
let useSiteMetadata = () => {
  let siteMetadataQueryResult: SiteMetadataQuery.Raw.t = Gatsby.useStaticQuery(SiteMetadataQuery.query);
  let site = Js.Nullable.toOption(siteMetadataQueryResult.site)
  switch site {
  | None => Js.Exn.raiseError("Exception: site is not found!")
  | Some(result) =>
    switch Js.Nullable.toOption(result.siteMetadata) {
      | None => Js.Exn.raiseError("Exception: siteMetadata is not found!")
      | Some(result) =>  result
    }
  }
};
