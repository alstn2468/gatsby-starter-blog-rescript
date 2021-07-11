@react.component
let make = (~children: React.element) => {
  let siteMetadata = SiteMetadata.useSiteMetadata()
  <>
    <SEO
      title={siteMetadata.title} description={siteMetadata.description} url={siteMetadata.siteUrl}
    />
    {children}
  </>
}

let default = make
