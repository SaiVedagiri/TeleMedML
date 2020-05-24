import React from 'react';
import { BrowserRouter as Router, Route} from 'react-router-dom';
import View from "./View";


function App() {
  return (
    <div className="App">
      <Router>
        <div>
          <Route exact path="/" component={View} />
        </div>
      </Router>
    </div>
  );
}

export default App;
