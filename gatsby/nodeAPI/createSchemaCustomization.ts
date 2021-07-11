import type { GatsbyNodeAPI } from './types';

export const createSchemaCustomization: GatsbyNodeAPI<'createSchemaCustomization'> = ({
  actions: {
    createTypes,
  },
}) => {
  const gql = String.raw;
  const markdownRemarkType = gql`
    type MarkdownRemarkFrontmatter {
      title: String!
      date(formatString: String): Date!
      category: String!
      draft: Boolean!
    }
    type MarkdownRemarkFields {
      slug: String!
    }
    type MarkdownRemark implements Node {
      frontmatter: MarkdownRemarkFrontmatter!
      fields: MarkdownRemarkFields!
      excerpt(pruneLength: Int): String!
      html: String!
    }
  `;
  const siteType = gql`
    type SiteSiteMetadata {
      author: String!
      introduction: String!
      title: String!
      description: String!
      siteUrl: String!
    }
    type Site implements Node {
      siteMetadata: SiteSiteMetadata!
    }
  `;
  createTypes([markdownRemarkType, siteType]);
};
