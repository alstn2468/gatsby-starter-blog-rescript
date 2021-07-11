@react.component
let make = (~children: React.element) => {
  let siteMetadata = SiteMetadata.useSiteMetadata()
  let title = Option.getValueFromNullable(siteMetadata.title, "")
  let description = Option.getValueFromNullable(siteMetadata.description, "")
  let siteUrl = Option.getValueFromNullable(siteMetadata.siteUrl, "")
  <> <SEO title={title} description={description} url={siteUrl} /> {children} </>
}

let default = make
