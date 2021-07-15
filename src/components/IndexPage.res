let getUniqItemArray = array => {
  let acc = (array, item) => {
    switch Js.Array2.includes(array, item) {
    | true => array
    | false => array->Js.Array2.concat([item])
    }
  }
  array->Js.Array2.reduce(acc, [])
}

@react.component
let make = (~location: Gatsby.location) => {
  let (category, selectCategory) = UseCategory.useCategory()
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

  let categories =
    markdownRemarkNodes->Js.Array2.map(getFrontMatter)->Js.Array2.map(getCategory)->getUniqItemArray
  <>
    <ThemeSwitch />
    <Title title={siteMetadata.title} />
    <Bio />
    <Category categories selectedCategory={category} selectCategory />
    <div style={ReactDOM.Style.make(~height="2000px", ())} />
  </>
}

@genType let default = make
