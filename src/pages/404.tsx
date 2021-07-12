import * as React from 'react';
import { navigate } from 'gatsby';

const NotFoundPage: React.FC = () => {
  React.useEffect(() => {
    void navigate('/', { replace: true });
  }, []);
  return null;
};

export default NotFoundPage;
