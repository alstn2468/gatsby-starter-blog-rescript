let make = (~location: Gatsby.location) => {
  let (siteMetadata, markdownRemarkNodes) = MainPageData.useMainPageData()
  <div> <h1> {React.string("Hello World!")} </h1> </div>
}

@genType let default = make
