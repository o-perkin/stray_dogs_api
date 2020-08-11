import React, { Component } from 'react';
import './App.css';
import DogsContainer from './components/DogsContainer';

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1 className="App-title">Hello Hiplyst!</h1>
        </header>
        <DogsContainer />
      </div>
    );
  }
}

export default App;