

import type { GatsbyBrowser } from 'gatsby';

import smoothscroll from 'smoothscroll-polyfill';

export const onClientEntry: GatsbyBrowser['onClientEntry'] = async () => {
  smoothscroll.polyfill();
};
