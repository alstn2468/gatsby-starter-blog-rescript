
import type { GatsbyNodeAPI } from './types';
import path from 'path';
import * as Either from 'fp-ts/lib/Either';
import * as Arr from 'fp-ts/lib/Array';
import { pipe, identity } from 'fp-ts/lib/function';

export const createPages: GatsbyNodeAPI<'createPages'> = async ({
  graphql,
  actions: { createPage: baseCreatePage },
}) => {
  type MarkdownRemarkNode = {
    fields: { slug: string },
    frontmatter: { title: string, category: string, draft: boolean },
  };
  type MarkdownRemarkNodes = {
    allMarkdownRemark: {
      nodes: MarkdownRemarkNode[],
    },
  };
  type Nullable<T> = T | null;
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
    }
  `;
  const pageComponentPath = path.resolve('src/templates/PostDetail.gen.tsx');
  const markdownRemarkQueryResult = await graphql<MarkdownRemarkNodes>(
    markdownRemarkQuery,
  );

  const queryHasError = (
    queryResult: typeof markdownRemarkQueryResult,
  ): boolean => !queryResult.errors;

  const isVisibleMarkdownRemarkNode = (node: MarkdownRemarkNode) =>
    (process.env.NODE_ENV === 'development' || !node.frontmatter.draft) &&
    !!node.frontmatter.category;

  const getPreviousNode = (
    currentNodeIndex: number,
    nodes: MarkdownRemarkNode[],
  ) =>
    currentNodeIndex === nodes.length - 1 ? null : nodes[currentNodeIndex + 1];

  const getNextNode = (currentNodeIndex: number, nodes: MarkdownRemarkNode[]) =>
    currentNodeIndex === 0 ? null : nodes[currentNodeIndex - 1];

  const getNodeWithPreviousAndNextNode =
    (nodes: MarkdownRemarkNode[]) =>
      (currentNodeIndex: number, currentNode: MarkdownRemarkNode ) => ({
        ...currentNode,
        previous: getPreviousNode(currentNodeIndex, nodes),
        next: getNextNode(currentNodeIndex, nodes),
      });

  const getCreateMarkdownRemarkPages =
    (createPage: typeof baseCreatePage, pageComponentPath: string) =>
      (
        remarkdownNode: MarkdownRemarkNode & {
          previous: Nullable<MarkdownRemarkNode>,
          next: Nullable<MarkdownRemarkNode>,
        },
      ) =>
        createPage({
          path: remarkdownNode.fields.slug,
          component: pageComponentPath,
          context: {
            previous: remarkdownNode.previous,
            next: remarkdownNode.next,
          },
        });

  const getMarkdownRemarkNodes = (
    markdownRemarkQueryResult: { data?: MarkdownRemarkNodes, errors?: unknown },
  ) => pipe(
    markdownRemarkQueryResult,
    Either.fromPredicate(queryHasError, (e) => {
      throw e.errors;
    }),
    Either.map((result) => result.data?.allMarkdownRemark.nodes ?? []),
    Either.fold(() => [], identity),
  );

  const createPageByMarkdownRemarkNodes = (
    pageComponentPath: string,
    createPage: typeof baseCreatePage,
  ) => (markdownRemarkNodes: MarkdownRemarkNode[]) =>
    pipe(
      markdownRemarkNodes,
      Arr.filter(isVisibleMarkdownRemarkNode),
      (nodes) =>
        pipe(
          nodes,
          Arr.mapWithIndex(getNodeWithPreviousAndNextNode(nodes)),
          Arr.map(getCreateMarkdownRemarkPages(createPage, pageComponentPath)),
        ),
    );

  pipe(
    markdownRemarkQueryResult,
    getMarkdownRemarkNodes,
    createPageByMarkdownRemarkNodes(pageComponentPath, baseCreatePage),
  );
};
