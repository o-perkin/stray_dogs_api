import React, { Component } from 'react';
import { Route, Switch } from "react-router-dom";
import {NotificationManager} from 'react-notifications';
// pages for this product
import Components from "views/Components/Components.js";
import LandingPage from "views/LandingPage/LandingPage.js";
import ProfilePage from "views/ProfilePage/ProfilePage.js";
import LoginPage from "views/LoginPage/LoginPage.js";
import RegisterPage from "views/RegisterPage/RegisterPage.js";
import MyListPage from "views/MyListPage/MyListPage.js";
import FavoritesPage from "views/FavoritesPage/FavoritesPage.js";
import SubscriptionsPage from "views/SubscriptionsPage/SubscriptionsPage.js";
import NewDogsPage from "views/NewDogsPage/NewDogsPage.js";
import EditDogsPage from "views/EditDogsPage/EditDogsPage.js";
import DogsShowPage from "views/DogsShowPage/DogsShowPage.js";
import { LoopCircleLoading } from 'react-loadingg';
import axios from 'axios';
import * as jwtDecode from 'jwt-decode';

export default class App extends Component {
  constructor() {
    super();

    this.state = {
      loggedInStatus: this.checkLoginStatus(),
      user: this.checkUser()
    }
    
    console.log('state', this.state)

    this.handleLogin = this.handleLogin.bind(this);
    this.handleLogout = this.handleLogout.bind(this);
    this.checkLoginStatus = this.checkLoginStatus.bind(this);
    this.checkUser = this.checkUser.bind(this);
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

  checkUser() {
    axios.get('http://localhost:3001/api/v1/my_list.json', {
      headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
      withCredentials: true
    }).then(response => {
      this.setState({
        user: response.data.data.user
      })
      })
      .catch(error => console.log(error))
  }

  createNotification(type, title, message) {
    switch (type) {
      case 'info':
        NotificationManager.info(message, title, 3000);
        break;
      case 'success':
        NotificationManager.success(message, title, 3000);
        break;
      case 'warning':
        NotificationManager.warning(message, title, 3000);
        break;
      case 'error':
        NotificationManager.error(message, title, 5000);
        break;
    }
  }

  render() {
    //if (this.state.user && this.state.user.roles) {
      return (
        <Switch>
          <Route
            exact 
            path="/dogs" 
            render={props => (
              <LandingPage {...props} current_user={this.state.user ? this.state.user : {}} createNotification={this.createNotification}   handleLogout={this.handleLogout} loggedInStatus={this.state.loggedInStatus} />
            )}
          />
          <Route 
            path="/dogs/edit/:dogId" 
            render={props => (
              <EditDogsPage {...props} createNotification={this.createNotification}  handleLogout={this.handleLogout} loggedInStatus={this.state.loggedInStatus} />
            )}
          />
          <Route
            exact 
            path="/dogs/new" 
            render={props => (
              <NewDogsPage {...props} handleLogout={this.handleLogout} loggedInStatus={this.state.loggedInStatus} />
            )}
          />
          <Route 
            path="/dogs/:dogId" 
            render={props => (
              <DogsShowPage {...props} createNotification={this.createNotification}  handleLogout={this.handleLogout} loggedInStatus={this.state.loggedInStatus} />
            )}
          />
          <Route
            exact 
            path="/profile" 
            render={props => (
              <ProfilePage {...props} createNotification={this.createNotification}  handleLogout={this.handleLogout} loggedInStatus={this.state.loggedInStatus} state={this.state} />
            )}
          />
          <Route
            exact 
            path="/registration" 
            render={props => (
              <RegisterPage {...props} createNotification={this.createNotification} handleLogout={this.handleLogout} handleLogin={this.handleLogin} loggedInStatus={this.state.loggedInStatus} />
            )}
          />
          <Route
            exact 
            path="/login"
            render={props => (
              <LoginPage {...props} createNotification={this.createNotification} handleLogout={this.handleLogout} handleLogin={this.handleLogin} loggedInStatus={this.state.loggedInStatus} />
            )}
          />
          <Route
            exact 
            path="/" 
            render={props => (
              <Components {...props} handleLogout={this.handleLogout} loggedInStatus={this.state.loggedInStatus} />
            )}
          />
          <Route
            exact 
            path="/my_list" 
            render={props => (
              <MyListPage {...props} handleLogout={this.handleLogout} loggedInStatus={this.state.loggedInStatus} />
            )}
          />
          <Route
            exact 
            path="/favorites" 
            render={props => (
              <FavoritesPage {...props} handleLogout={this.handleLogout} loggedInStatus={this.state.loggedInStatus} />
            )}
          />
          <Route
            exact 
            path="/subscriptions" 
            render={props => (
              <SubscriptionsPage {...props} handleLogout={this.handleLogout} loggedInStatus={this.state.loggedInStatus} />
            )}
          />
        </Switch>
      );
    /// } else {
    //  return <LoopCircleLoading color='purple' />
    //}
  }
}