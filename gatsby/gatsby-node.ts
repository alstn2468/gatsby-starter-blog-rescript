import type { GatsbyNode, Node } from 'gatsby';
import path from 'path';
import * as IO from 'fp-ts/lib/IO';
import * as Option from 'fp-ts/lib/Option';
import { constVoid, pipe } from 'fp-ts/lib/function';

export const onCreateNode: GatsbyNode['onCreateNode'] = ({
  node,
  getNode,
  actions: {
    createNodeField,
  },
}) => {
  interface FileNode extends Node {
    relativePath: string
  }
  const getFileNameFromFileNode = (fileNode: FileNode) =>
    path.parse(fileNode.relativePath).name;
  const createNodeWithSlug = (markdownRemarkNode: Node) => pipe(
    markdownRemarkNode,
    IO.of,
    IO.map((node) => ({
      fileNode: getNode(node.parent as string),
      markdownRemarkNode,
    })),
    IO.map(({ fileNode, markdownRemarkNode }) => ({
      markdownRemarkNode, slug: getFileNameFromFileNode(fileNode as FileNode)
    })),
    IO.map(({ markdownRemarkNode, slug }) => createNodeField({
      node: markdownRemarkNode,
      name: 'slug',
      value: slug,
    })),
  );
  const isMarkdownRemarkNode = (node: Node) => node.internal.type === 'MarkdownRemark';
  const run = (node: Node) => pipe(
    node,
    Option.fromPredicate(isMarkdownRemarkNode),
    Option.match(
      constVoid,
      createNodeWithSlug,
    ),
  );
  run(node);
};
