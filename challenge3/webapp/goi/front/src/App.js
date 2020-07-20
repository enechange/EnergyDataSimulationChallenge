import React, { Component } from 'react';
import Home from './Home/App';

const style = {
  textAlign: '-webkit-center',
  display: 'inherit',
  padding: '50px 0px 30px',
  color: '#778899',
  background: '#e6e6fa',
};

class App extends Component {
  render() {
    return (
      //returnの中にJSXを記載
      <div style={style}>
        <Home />
        <h1>Comming soon...</h1>
        <h2>Comming soon...</h2>
        <h3>Comming soon...</h3>
      </div>
    );
  }
}

export default App;
