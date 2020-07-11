//必須
import React, { Component } from 'react';
import Home from './Home/App';

//Appクラス = Appコンポーネント(カスタムタグ)
class App extends Component {
  render() {
    return (
      //returnの中にJSXを記載
      <div className="driver">
        <Home />
      </div>
    );
  }
}

//他の場所で読み込んで使えるようにexport
export default App;
