let make = (~location: Gatsby.location) => {
  let (siteMetadata, markdownRemarkNodes) = MainPageData.useMainPageData()
  <> <ThemeSwitch /> <Title title={siteMetadata.title} /> <Bio /> </>
}

@genType let default = make
