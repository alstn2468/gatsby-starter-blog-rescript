
import type { GatsbyConfig } from 'gatsby';

import dotenv from 'dotenv-safe';

dotenv.config();

if (!process.env.PUBLIC_URL) {
  throw new Error('PUBLIC_URL 환경변수를 세팅해주세요.');
}

const publicURL = new URL(process.env.PUBLIC_URL);

const siteMetadata: GatsbyConfig['siteMetadata'] = {
  title: 'gatsby-starter-blog-reason',
  description: '🍭 Gatsby blog template using ReasonML',
  siteUrl: publicURL.origin,
};

const flags: GatsbyConfig['flags'] = {
  FAST_DEV: true,
  QUERY_ON_DEMAND: true,
  LAZY_IMAGES: true,
  PARALLEL_SOURCING: true,
};

const plugins: GatsbyConfig['plugins'] = [
  {
    resolve: `gatsby-plugin-manifest`,
    options: {
      name: 'gatsby-starter-blog-reason',
      short_name: 'gatsby-starter-blog-reason',
      start_url: `/`,
      background_color: `#ffffff`,
      theme_color: `#663399`,
      display: `minimal-ui`,
      icon: 'src/images/icon.png',
    },
  },
  {
    resolve: 'gatsby-plugin-reason',
    options: {
      derivePathFromComponentName: true,
    },
  },
];

const config: GatsbyConfig = {
  flags,
  siteMetadata,
  plugins,
};

export default config;
