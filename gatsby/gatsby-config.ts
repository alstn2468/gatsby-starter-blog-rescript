import type { GatsbyConfig } from 'gatsby';
import dotenv from 'dotenv-safe';

import { metaConfig } from './gatsby-config-meta';

dotenv.config();

if (!process.env.PUBLIC_URL) {
  throw new Error('PUBLIC_URL 환경변수를 세팅해주세요.');
}

const publicURL = new URL(process.env.PUBLIC_URL);

const siteMetadata: GatsbyConfig['siteMetadata'] = {
  title: 'gatsby-starter-blog-rescript',
  description: '🍭 Gatsby blog template using Rescript',
  siteUrl: publicURL.origin,
  ...metaConfig,
};

const plugins: GatsbyConfig['plugins'] = [
  'gatsby-plugin-sharp',
  'gatsby-transformer-sharp',
  'gatsby-plugin-react-helmet-async',
  'gatsby-plugin-next-seo',
  'gatsby-plugin-feed',
  'gatsby-plugin-offline',
  'gatsby-plugin-sitemap',
  'gatsby-plugin-robots-txt',
  {
    resolve: 'gatsby-plugin-layout',
    options: {
      component: require.resolve('./src/layouts/DefaultLayout.bs.js'),
    },
  },
  {
    resolve: 'gatsby-plugin-manifest',
    options: {
      name: 'gatsby-starter-blog-reason',
      short_name: 'gatsby-starter-blog-reason',
      start_url: '/',
      background_color: '#ffffff',
      theme_color: '#663399',
      display: 'minimal-ui',
      icon: 'content/assets/icon.png',
    },
  },
  {
    resolve: 'gatsby-source-filesystem',
    options: {
      path: `${__dirname}/content/post`,
      name: 'post',
    },
  },
  {
    resolve: 'gatsby-source-filesystem',
    options: {
      path: `${__dirname}/content/assets`,
      name: 'assets',
    },
  },
  {
    resolve: 'gatsby-transformer-remark',
    options: {
      plugins: [
        {
          resolve: 'gatsby-remark-katex',
          options: {
            strict: 'ignore',
          },
        },
        {
          resolve: 'gatsby-remark-images',
          options: {
            maxWidth: 600,
            linkImagesToOriginal: false,
          },
        },
        {
          resolve: 'gatsby-remark-images-medium-zoom',
          options: {
            margin: 12,
            scrollOffset: 0,
          },
        },
        {
          resolve: 'gatsby-remark-responsive-iframe',
          options: {
            wrapperStyle: 'margin-bottom: 1.0725rem',
          },
        },
        {
          resolve: 'gatsby-remark-prismjs',
          options: {
            inlineCodeMarker: '%',
          },
        },
        'gatsby-remark-copy-linked-files',
        'gatsby-remark-smartypants',
        'gatsby-remark-autolink-headers',
        'gatsby-remark-emoji',
      ],
    },
  },
  {
    resolve: 'gatsby-plugin-google-analytics',
    options: {
      trackingId: metaConfig.ga,
    },
  },
  {
    resolve: 'gatsby-plugin-canonical-urls',
    options: {
      siteUrl: publicURL.origin,
    },
  },
];

const config: GatsbyConfig = {
  siteMetadata,
  plugins,
};

export default config;
