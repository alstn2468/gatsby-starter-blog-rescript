import type { PageProps } from 'gatsby';
import * as React from 'react';
import IndexPageComponent from '../components/IndexPage.gen';


const IndexPage: React.FC<PageProps> = ({
  location,
}) => <IndexPageComponent location={location} />;

export default IndexPage;
