import React, { Component } from 'react';
import axios from 'axios';


import InputAdornment from "@material-ui/core/InputAdornment";
import Icon from "@material-ui/core/Icon"; 

// @material-ui/icons
import Email from "@material-ui/icons/Email";
import People from "@material-ui/icons/People";

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

import * as jwtDecode from 'jwt-decode';

export default class EditAccount extends Component {
  constructor(props) {
    super(props);

    this.state = {
      email: localStorage.getItem('user_email'),
      first_name: localStorage.getItem('first_name'),
      last_name: localStorage.getItem('last_name'),
      password: "",
      password_confirmation: "",
      current_password: ""
    }

    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(event) {
    this.setState({
      [event.target.name]: event.target.value
    })
  }

  handleSubmit(event) {
    axios.put("http://localhost:3000/", {
      user: {
        email: this.state.email,
        first_name: this.state.first_name,
        last_name: this.state.last_name,
        password: this.state.password,
        password_confirmation: this.state.password_confirmation,
        current_password: this.state.current_password
      }
    }, 
    {
      headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
      withCredentials: true
    }).then(response => {
      if(response.status === 204) {
        localStorage.setItem('user_email', this.state.email);
        localStorage.setItem('first_name', this.state.first_name);
        localStorage.setItem('last_name', this.state.last_name);
        this.props.history.go(0)
      }
      console.log("response", response);
      
    }).catch(error => {
      console.log("registration error", error.response);

      if ('email' in error.response.data.errors) {
        this.props.createNotification('error', 'Error', 'Email has already been taken')
      } else if ('password' in error.response.data.errors) {
        this.props.createNotification('error', 'Error', 'Password should have minimum 6 characters')
      } else if ('password_confirmation' in error.response.data.errors) {
        this.props.createNotification('error', 'Error', "Passwords don't match")
      } else if ('current_password' in error.response.data.errors) {
        this.props.createNotification('error', 'Error', "Wrong password")
      }
    })
    event.preventDefault();
  }    

  render() {
    return (
      <form className={this.props.classes.form} onSubmit={this.handleSubmit} >
        <CardHeader color="primary" className={this.props.classes.cardHeader} >
          <h4>Edit Profile</h4>
        </CardHeader>

        <CardBody>
          <CustomInput
            labelText="Email"
            id="first"
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
            labelText="First Name"
            id="first_name"
            formControlProps={{
              fullWidth: true
            }}
            inputProps={{
              type: "first_name",
              name: "first_name",
              value: this.state.first_name,
              onChange: this.handleChange,
              endAdornment: (
                <InputAdornment position="end">
                  <People className={this.props.classes.inputIconsColor} />
                </InputAdornment>
              ),
              required: true
            }}
          />

          <CustomInput
            labelText="Last Name"
            id="last_name"
            formControlProps={{
              fullWidth: true
            }}
            inputProps={{
              type: "last_name",
              name: "last_name",
              value: this.state.last_name,
              onChange: this.handleChange,
              endAdornment: (
                <InputAdornment position="end">
                  <People className={this.props.classes.inputIconsColor} />
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
              autoComplete: "off"
            }}
          />
          <CustomInput
            labelText="Password Confirmation"
            id="pass_confirm"
            formControlProps={{
              fullWidth: true
            }}
            inputProps={{
              type: "password_confirmation",
              name: "password_confirmation",
              value: this.state.password_confirmation,
              onChange: this.handleChange,
              endAdornment: (
                <InputAdornment position="end">
                  <Icon className={this.props.classes.inputIconsColor}>
                    lock_outline
                  </Icon>
                </InputAdornment>
              ),
              autoComplete: "off"
            }}
          />

          <CustomInput
            labelText="Current Password..."
            id="current_pass"
            formControlProps={{
              fullWidth: true
            }}
            inputProps={{
              type: "current_password",
              name: "current_password",
              value: this.state.current_password,
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
            Update Profile
          </Button>
        </CardFooter>    
      </form> 
    )
  }
}