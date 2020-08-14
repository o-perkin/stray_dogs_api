import React, { Component } from 'react';
import { Route, Switch } from "react-router-dom";

// pages for this product
import Components from "views/Components/Components.js";
import LandingPage from "views/LandingPage/LandingPage.js";
import ProfilePage from "views/ProfilePage/ProfilePage.js";
import LoginPage from "views/LoginPage/LoginPage.js";
import RegisterPage from "views/RegisterPage/RegisterPage.js";
import * as jwtDecode from 'jwt-decode';

export default class App extends Component {
  constructor() {
    super();

    this.state = {
      loggedInStatus: "NOT_LOGGED_IN",
      user: {}
    }

    this.handleLogin = this.handleLogin.bind(this);
  }

  handleLogin(data) {
    this.setState({
      loggedInStatus: "LOGGED_IN",
      user: data.data
    })
  }

  checkIfLoggedIn() {    
    var token = localStorage.getItem('token').replace('Bearer','');  
    if (token != null) {
      var decoded = jwtDecode(token);
      var current_time = Date.now() / 1000;
      if ( decoded.exp < current_time) {
        this.setState({
          loggedInStatus: "NOT_LOGGED_IN",
          user: {}       
        })       
      } else {
        this.setState({
          loggedInStatus: "LOGGED_IN"
        })
      }
    } else {
        this.setState({
          loggedInStatus: "NOT_LOGGED_IN",
          user: {}
        })
      }    
  }

  componentDidMount() {
    this.checkIfLoggedIn();
  }

  render() {
    return (
      <Switch>
        <Route 
          path="/dogs" 
          render={props => (
            <LandingPage {...props} loggedInStatus={this.state.loggedInStatus} />
          )}
        />
        <Route 
          path="/profile-page" 
          render={props => (
            <ProfilePage {...props} loggedInStatus={this.state.loggedInStatus} />
          )}
        />
        <Route 
          path="/registration" 
          render={props => (
            <RegisterPage {...props} handleLogin={this.handleLogin} loggedInStatus={this.state.loggedInStatus} />
          )}
        />
        <Route 
          path="/login"
          render={props => (
            <LoginPage {...props} loggedInStatus={this.state.loggedInStatus} />
          )}
        />
        <Route 
          path="/" 
          render={props => (
            <Components {...props} loggedInStatus={this.state.loggedInStatus} />
          )}
        />
      </Switch>
    );
  }
}