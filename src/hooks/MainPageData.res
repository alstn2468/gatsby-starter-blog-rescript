%graphql(`
  query MainPageQuery {
    site {
      siteMetadata {
        title
        configs {
          countOfInitialPost
        }
      }
    }
    allMarkdownRemark(
      sort: { fields: [frontmatter___date], order: [DESC] }
    ) {
      nodes {
        excerpt(pruneLength: 200, truncate: true)
        fields {
          slug
        }
        frontmatter {
          date(formatString: "MMMM DD, YYYY")
          title
          category
          draft
        }
      }
    }
  }
`)

let useMainPageData = () => {
  let mainPageQueryResult: MainPageQuery.Raw.t = Gatsby.useStaticQuery(MainPageQuery.query)
  let site = Js.Nullable.toOption(mainPageQueryResult.site)
  let markdownRemarkNodes = mainPageQueryResult.allMarkdownRemark.nodes
  let siteMetadata = switch site {
  | None => Js.Exn.raiseError("(MainPageQuery)Exception: site is not found.")
  | Some(site) => site.siteMetadata
  }
  (siteMetadata, markdownRemarkNodes)
}
