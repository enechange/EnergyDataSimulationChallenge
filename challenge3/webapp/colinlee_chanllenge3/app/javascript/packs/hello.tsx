import * as React from 'react';

interface HelloProps {
  name: string;
}

const Hello: React.FunctionComponent<HelloProps> = ({ name }) => (
  <h2>hello</h2>
);

export default Hello;
