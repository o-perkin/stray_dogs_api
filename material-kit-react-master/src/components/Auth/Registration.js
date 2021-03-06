import React, { Component } from 'react';
import axios from 'axios';
import { LoopCircleLoading } from 'react-loadingg';

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

export default class Registration extends Component {
  constructor(props) {
    super(props);

    this.state = {
      email: "",
      first_name: "",
      last_name: "",
      password: "",
      password_confirmation: "",
      animate: false
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
    this.setState({
      animate: true,
    })
    axios.post("http://localhost:3000/", {
      user: {
        email: this.state.email,
        first_name: this.state.first_name,
        last_name: this.state.last_name,
        password: this.state.password,
        password_confirmation: this.state.password_confirmation
      }
    }, 
    {
      headers: {'Accept': '*/*'},
      withCredentials: true
    }).then(response => {
      if(response.status === 201) {
        localStorage.setItem('token', response.headers.authorization);
        localStorage.setItem('user_email', response.data.email);
        localStorage.setItem('first_name', response.data.first_name);
        localStorage.setItem('last_name', response.data.last_name);
        this.props.handleSuccessfulAuth(response);
      }
      this.setState({
        animate: false,
      })
      console.log("response", response);
      
    }).catch(error => {
      console.log("registration error", error.response);
      if ('email' in error.response.data.errors) {
        this.props.createNotification('error', 'Error', 'Email has already been taken')
      } else if ('password' in error.response.data.errors) {
        this.props.createNotification('error', 'Error', 'password should have minimum 6 characters')
      } else if ('password_confirmation' in error.response.data.errors) {
        this.props.createNotification('error', 'Error', "passwords don't match")
      }
      this.setState({
        animate: false,
      })
    })
    event.preventDefault();
  }    

  render() {
    return (
      <form className={this.props.classes.form} onSubmit={this.handleSubmit} >
        <CardHeader color="primary" className={this.props.classes.cardHeader} >
          <h4>Registration</h4>
          <div className={this.props.classes.socialLine}>
            <Button
              justIcon
              href="#pablo"
              target="_blank"
              color="transparent"
              onClick={e => e.preventDefault()}
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
              required: true,
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
              required: true,
              autoComplete: "off"
            }}
          />
        
        </CardBody>
          
        <CardFooter className={this.props.classes.cardFooter}>
          <Button type="submit" simple color="primary" size="lg" disabled={this.state.animate ? "disabled" : ""}>
            Register
          </Button>
          <LoopCircleLoading color='purple' style={this.state.animate ? {} : {display: "none"}} />
        </CardFooter>    
      </form> 
    )
  }
}