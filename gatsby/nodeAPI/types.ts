import type { GatsbyNode } from 'gatsby';

export type GatsbyNodeAPI<T extends keyof GatsbyNode> = GatsbyNode[T] extends infer U
  ? U extends ((...args: infer Params) => unknown)
  ? ((...args: Params) => (void | Promise<void>))
  : never
  : never;
