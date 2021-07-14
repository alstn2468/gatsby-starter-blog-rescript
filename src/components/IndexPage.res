@react.component
let make = (~location: Gatsby.location) => {
  let (category, setCategory) = React.useState(_ => "All")
  let (siteMetadata, markdownRemarkNodes) = MainPageData.useMainPageData()
  let countOfInitialPost = switch Js.Nullable.toOption(siteMetadata.configs) {
  | Some(configs) =>
    switch Js.Nullable.toOption(configs.countOfInitialPost) {
    | Some(countOfInitialPost) => countOfInitialPost
    | None => 10
    }
  | None => 10
  }
  let getFrontMatter = (
    markdownRemarkNode: MainPageData.MainPageQuery.Raw.t_allMarkdownRemark_nodes,
  ) => markdownRemarkNode.frontmatter
  let getCategory = (
    frontmatter: MainPageData.MainPageQuery.Raw.t_allMarkdownRemark_nodes_frontmatter,
  ) => frontmatter.category
  let categories = markdownRemarkNodes->Js.Array2.map(getFrontMatter)->Js.Array2.map(getCategory)
  let selectCategory = category => {
    setCategory(_ => category)
    Js.log(category)
  }
  <>
    <ThemeSwitch />
    <Title title={siteMetadata.title} />
    <Bio />
    <Category categories selectedCategory={category} selectCategory />
  </>
}

@genType let default = make
