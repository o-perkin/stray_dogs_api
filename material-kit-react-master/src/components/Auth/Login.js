import React, { Component } from 'react';
import axios from 'axios';
import {NotificationManager} from 'react-notifications';

import InputAdornment from "@material-ui/core/InputAdornment";
import Icon from "@material-ui/core/Icon";
// @material-ui/icons
import Email from "@material-ui/icons/Email";
import People from "@material-ui/icons/People";
// core components
import Header from "components/Header/Header.js";
import HeaderLinks from "components/Header/HeaderLinks.js";
import Footer from "components/Footer/Footer.js";
import GridContainer from "components/Grid/GridContainer.js";
import GridItem from "components/Grid/GridItem.js";
import Button from "components/CustomButtons/Button.js";
import Card from "components/Card/Card.js";
import CardBody from "components/Card/CardBody.js";
import CardHeader from "components/Card/CardHeader.js";
import CardFooter from "components/Card/CardFooter.js";
import CustomInput from "components/CustomInput/CustomInput.js";

export default class Login extends Component {
  constructor(props) {
    super(props);

    this.state = {
      email: "",
      password: "",
      loginErrors: "",
      notifications: {
        type: "",
        title: '',
        message: ''
      }
    };

    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(event) {
    this.setState({
      [event.target.name]: event.target.value
    })
  }

  createNotification = (type) => {
    return () => {
      switch (type) {
        case 'info':
          NotificationManager.info('info');
          break;
        case 'success':
          NotificationManager.success('Success message', 'Title here');
          break;
        case 'warning':
          NotificationManager.warning('Warning message', 'Close after 3000ms', 3000);
          break;
        case 'error':
          NotificationManager.error('Error message', 'Click me!', 5000, () => {
            alert('callback');
          });
          break;
      }
    };
  };

  handleSubmit(event) {
    axios.post("http://localhost:3000/login", {
      user: {
        email: this.state.email,
        password: this.state.password
      }
    }, 
    {
      headers: {'Accept': '*/*'},
      withCredentials: true
    }).then(response => {
       console.log("response from login", response);
      if(response.status === 200) {
        localStorage.setItem('token', response.headers.authorization);
        localStorage.setItem('user_email', response.data.email);
        localStorage.setItem('first_name', response.data.first_name);
        localStorage.setItem('last_name', response.data.last_name);
        this.props.handleSuccessfulAuth(response);
      }      
    }).catch(error => {
      console.log("login error", error.message);
      if (error.message == 'Request failed with status code 401') {
        this.setState({
          loginErrors: "Envalid Email or Password"
        })
      }
    })
    event.preventDefault();
  }

  render() {
    return (
     <form className={this.props.classes.form} onSubmit={this.handleSubmit} >
        <CardHeader color="primary" className={this.props.classes.cardHeader}>
          <h4>Login</h4>
          <div className={this.props.classes.socialLine}>
            <Button
              justIcon
              href="#pablo"
              color="transparent"
            >
              <i className={"fab fa-twitter"} />
            </Button>
            <Button
              justIcon
              href="#pablo"
              target="_blank"
              color="transparent"
              onClick={e => e.preventDefault()}
            >
              <i className={"fab fa-facebook"} />
            </Button>
            <Button
              justIcon
              href="#pablo"
              target="_blank"
              color="transparent"
              onClick={e => e.preventDefault()}
            >
              <i className={"fab fa-google-plus-g"} />
            </Button>
          </div>
        </CardHeader>
        <p className={this.props.classes.divider}>{this.state.loginErrors}</p>
        <CardBody>
          <CustomInput
            labelText="Email..."
            id="email"
            formControlProps={{
              fullWidth: true
            }}
            inputProps={{
              type: "email",
              name: "email",
              value: this.state.email,
              onChange: this.handleChange,
              endAdornment: (
                <InputAdornment position="end">
                  <Email className={this.props.classes.inputIconsColor} />
                </InputAdornment>
              ),
              required: true
            }}
          />
          <CustomInput
            labelText="Password"
            id="pass"
            formControlProps={{
              fullWidth: true
            }}
            inputProps={{
              type: "password",
              name: "password",
              value: this.state.password,
              onChange: this.handleChange,
              endAdornment: (
                <InputAdornment position="end">
                  <Icon className={this.props.classes.inputIconsColor}>
                    lock_outline
                  </Icon>
                </InputAdornment>
              ),
              required: true,
              autoComplete: "off"
            }}
          />
        </CardBody>
        <CardFooter className={this.props.classes.cardFooter}>
          <Button type="submit" simple color="primary" size="lg">
            Login
          </Button>
        </CardFooter>
      </form>
    )
  }
}