import type { GatsbyNode, Node } from 'gatsby';
import path from 'path';
import * as IO from 'fp-ts/lib/IO';
import * as Option from 'fp-ts/lib/Option';
import { constVoid, pipe } from 'fp-ts/lib/function';

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
