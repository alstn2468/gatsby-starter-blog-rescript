import type { PageProps } from 'gatsby';
import * as React from 'react';
import Main from '../components/Pages/Main.gen';


const IndexPage: React.FC<PageProps> = ({
  location,
}) => <Main location={location} />;

export default IndexPage;
