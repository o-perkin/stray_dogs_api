import React, { Component } from 'react';
import { Route, Switch, useHistory } from "react-router-dom";

// pages for this product
import Components from "views/Components/Components.js";
import LandingPage from "views/LandingPage/LandingPage.js";
import ProfilePage from "views/ProfilePage/ProfilePage.js";
import LoginPage from "views/LoginPage/LoginPage.js";
import RegisterPage from "views/RegisterPage/RegisterPage.js";
import axios from 'axios';
import * as jwtDecode from 'jwt-decode';

export default class App extends Component {
  constructor() {
    super();

    this.state = {
      loggedInStatus: this.checkLoginStatus()
    }
    
    console.log('state', this.state)

    this.handleLogin = this.handleLogin.bind(this);
    this.handleLogout = this.handleLogout.bind(this);
    this.checkLoginStatus = this.checkLoginStatus.bind(this);
  }

  checkLoginStatus() {
    if (localStorage.getItem('token') != null) {
      var token = localStorage.getItem('token').replace('Bearer',''); 
      var decoded = jwtDecode(token);
      var current_time = Date.now() / 1000;
      if ( decoded.exp < current_time) {
        return 'NOT_LOGGED_IN';
      } else return 'LOGGED_IN'
    } else {
      return 'NOT_LOGGED_IN';
    }
  }

  handleLogin() {
    
    this.setState({
      loggedInStatus: "LOGGED_IN"
    })

  }

  handleLogout() {
    this.setState({
      loggedInStatus: "NOT_LOGGED_IN"
    })
  }

  render() {
    return (
      <Switch>
        <Route
          exact 
          path="/dogs" 
          render={props => (
            <LandingPage {...props} handleLogout={this.handleLogout} loggedInStatus={this.state.loggedInStatus} />
          )}
        />
        <Route
          exact 
          path="/profile" 
          render={props => (
            <ProfilePage {...props} handleLogout={this.handleLogout} loggedInStatus={this.state.loggedInStatus} state={this.state} />
          )}
        />
        <Route
          exact 
          path="/registration" 
          render={props => (
            <RegisterPage {...props} handleLogout={this.handleLogout} handleLogin={this.handleLogin} loggedInStatus={this.state.loggedInStatus} />
          )}
        />
        <Route
          exact 
          path="/login"
          render={props => (
            <LoginPage {...props} handleLogout={this.handleLogout} handleLogin={this.handleLogin} loggedInStatus={this.state.loggedInStatus} />
          )}
        />
        <Route
          exact 
          path="/home" 
          render={props => (
            <Components {...props} handleLogout={this.handleLogout} loggedInStatus={this.state.loggedInStatus} />
          )}
        />
      </Switch>
    );
  }
}