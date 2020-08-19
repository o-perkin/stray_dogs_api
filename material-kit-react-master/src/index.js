import React from "react";
import ReactDOM from "react-dom";
import { createBrowserHistory } from "history";
import { Router } from "react-router-dom";
import App from './App';

import "assets/scss/material-kit-react.scss?v=1.9.0";
import 'react-notifications/lib/notifications.css';
import "react-loadingmask/dist/react-loadingmask.css";
import 'bootstrap/dist/css/bootstrap.min.css';

var hist = createBrowserHistory();

ReactDOM.render(
  <Router history={hist}>
    <App />
  </Router>,
  document.getElementById("root")
);
