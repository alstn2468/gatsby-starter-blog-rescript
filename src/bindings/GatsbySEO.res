type metaTagItem = { name: string, content: string }
type metaTags = array<metaTagItem>
type openGraphImageItem = { url: string, width: int, height: int, alt: string }
type openGraph = {
  @as("type") _type: string,
  images: array<openGraphImageItem>,
  site_name: string,
  url: string,
  locale: string,
  title: string,
}

module Helemt = {
  @module("gatsby-plugin-next-seo") @react.component
  external make: (
    ~title: string,
    ~metaTags: metaTags,
    ~openGraph: openGraph,
    ~language: string,
    ~canonical: string,
  ) => React.element = "GatsbySeo"
}
