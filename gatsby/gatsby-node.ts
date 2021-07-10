import type { GatsbyNode, Node } from 'gatsby';
import path from 'path';
import * as IO from 'fp-ts/lib/IO';
import * as Option from 'fp-ts/lib/Option';
import * as Either from 'fp-ts/lib/Either';
import * as Arr from 'fp-ts/lib/Array';
import { constVoid, pipe, identity } from 'fp-ts/lib/function';

export const onCreateNode: GatsbyNode['onCreateNode'] = ({
  node,
  actions: {
    createNodeField,
  },
}) => {
  interface MarkdownRemarkNode extends Node {
    fileAbsolutePath: string
  }
  const getFileNameFromNode = (markdownRemarkNode: MarkdownRemarkNode): string =>
    path.parse(markdownRemarkNode.fileAbsolutePath).name;
  const createMarkdownRemarkNodeWithSlug = (markdownRemarkNode: Node) => pipe(
    markdownRemarkNode,
    IO.of,
    IO.map((markdownRemarkNode) => ({
      markdownRemarkNode,
      slug: getFileNameFromNode(markdownRemarkNode as MarkdownRemarkNode)
    })),
    IO.map(({ markdownRemarkNode, slug }) => createNodeField({
      node: markdownRemarkNode,
      name: 'slug',
      value: slug,
    })),
  );
  const isMarkdownRemarkNode = (node: Node) => node.internal.type === 'MarkdownRemark';
  const createMarkdwonNode = (node: Node) => pipe(
    node,
    Option.fromPredicate(isMarkdownRemarkNode),
    Option.match(
      () => constVoid,
      createMarkdownRemarkNodeWithSlug,
    ),
  );
  const run = createMarkdwonNode(node);
  run();
};

export const createPages: GatsbyNode['createPages'] = async ({
  graphql,
  actions: {
    createPage: baseCreatePage,
  },
}) => {
  const gql = String.raw;
  const markdownRemarkQuery = gql`
    {
      allMarkdownRemark(
        sort: { fields: [frontmatter___date], order: DESC }
        limit: 1000
      ) {
        nodes {
          frontmatter {
            title
            category
            draft
          }
          fields {
            slug
          }
        }
      }
    }`
  type MarkdownRemarkNode = {
    fields: { slug: string };
    frontmatter: { title: string, category: string, draft: boolean };
  };
  type MarkdownRemarkNodes = {
    allMarkdownRemark: {
      nodes: MarkdownRemarkNode[];
    };
  };
  const pageComponentPath = path.resolve("src/templates/PostDetail.gen.tsx");
  const markdownRemarkQueryResult = await graphql<MarkdownRemarkNodes>(markdownRemarkQuery);

  const queryHasError = (queryResult: typeof markdownRemarkQueryResult): boolean =>
    !queryResult.errors
  const isVisibleMarkdownRemarkNode = (node: MarkdownRemarkNode) =>
    (process.env.NODE_ENV === 'development' || !node.frontmatter.draft)
      && !!node.frontmatter.category;
  const getPreviousNode = (currentNodeIndex: number, nodes: MarkdownRemarkNode[]) =>
    currentNodeIndex === nodes.length - 1 ? null : nodes[currentNodeIndex + 1];
  const getNextNode = (currentNodeIndex: number, nodes: MarkdownRemarkNode[]) =>
      currentNodeIndex === 0 ? null : nodes[currentNodeIndex - 1];

  const markdownRemarkNodes = pipe(
    markdownRemarkQueryResult,
    Either.fromPredicate(
      queryHasError,
      (e) => { throw e.errors },
    ),
    Either.map((result) => result.data?.allMarkdownRemark.nodes ?? []),
    Either.fold(() => [], identity),
  );

  const createPageByMarkdownRemarkNodes = (
    createPage: typeof baseCreatePage,
    pageComponentPath: string,
  ) => pipe(
    markdownRemarkNodes,
    Arr.filter(isVisibleMarkdownRemarkNode),
    (nodes) => pipe(
      nodes,
      Arr.mapWithIndex((index, node) => ({
        ...node,
        previous: getPreviousNode(index, nodes),
        next: getNextNode(index, nodes),
      })),
      Arr.map(({ fields: { slug }, previous, next }) =>
        createPage({
          path: slug,
          component: pageComponentPath,
          context: { slug, previous, next },
        }),
      ),
    ),
  );
  createPageByMarkdownRemarkNodes(baseCreatePage, pageComponentPath);
};
