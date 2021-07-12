let make = (~location: Gatsby.location) => {
  let (siteMetadata, markdownRemarkNodes) = MainPageData.useMainPageData()

  <> <ThemeSwitch /> </>
}

@genType let default = make
