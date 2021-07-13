let make = (~location: Gatsby.location) => {
  let (siteMetadata, markdownRemarkNodes) = MainPageData.useMainPageData()
  <> <ThemeSwitch /> <Bio /> </>
}

@genType let default = make
