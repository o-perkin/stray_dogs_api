import React, { Component } from 'react';
import axios from 'axios';

export default class Registration extends Component {
  constructor(props) {
    super(props);

    this.state = {
      email: "",
      first_name: "",
      last_name: "",
      password: "",
      password_confirmation: "",
      registrationErrors: ""
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
      console.log("reg response", response); 
    }).catch(error => {
      console.log("registration error", error);
    })
    event.preventDefault();
  }

  render() {
    return (
      <div>
        <form onSubmit={this.handleSubmit}>
          <input
            type="email"
            name="email" 
            placeholder="Email" 
            value={this.state.email} 
            onChange={this.handleChange} 
            required 
          />

          <input
            type="first_name"
            name="first_name" 
            placeholder="First name" 
            value={this.state.first_name}
            onChange={this.handleChange} 
            required 
          />

          <input
            type="last_name"
            name="last_name" 
            placeholder="Last name" 
            value={this.state.last_name} 
            onChange={this.handleChange} 
            required 
          />

          <input
            type="password"
            name="password" 
            placeholder="Password" 
            value={this.state.password} 
            onChange={this.handleChange} 
            required 
          />

          <input
            type="password"
            name="password_confirmation" 
            placeholder="Password confirmation" 
            value={this.state.password_confirmation} 
            onChange={this.handleChange} 
            required 
          />

          <button type="submit">Register</button>
        </form>
      </div>
    )
  }
}