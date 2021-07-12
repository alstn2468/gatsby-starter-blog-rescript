%%raw("import './index.scss'")

@react.component
let make = (~children: React.element, ~location: Gatsby.location) => {
  let siteMetadata = SiteMetadata.useSiteMetadata()
  <>
    <Header title={siteMetadata.title} pathname={location.pathname} />
    <SEO
      title={siteMetadata.title} description={siteMetadata.description} url={siteMetadata.siteUrl}
    />
    <div className="container"> {children} </div>
  </>
}

let default = make
