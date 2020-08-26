import React, { Component } from 'react';
import axios from 'axios';
import { LoopCircleLoading } from 'react-loadingg';
import { Form } from 'react-bootstrap';

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
import InputLabel from '@material-ui/core/InputLabel';
import MenuItem from '@material-ui/core/MenuItem';
import FormHelperText from '@material-ui/core/FormHelperText';
import FormControl from '@material-ui/core/FormControl';
import Select from '@material-ui/core/Select';
import * as jwtDecode from 'jwt-decode';

export default class FiltersForm extends Component {
  constructor(props) {
    super(props);

    this.state = {
      breed: "",
      city: "",
      age_from: "",
      age_to: "",
      animate: false
    }

    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  componentDidMount() {
    axios.get('http://localhost:3001/api/v1/new_dog.json', {
      headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
      withCredentials: true
    }).then(response => {
        this.setState({
          params: response.data.data,
        })
      }).catch(error => console.log(error))
  }

  handleChange(event) {
    this.setState({
      [event.target.name]: event.target.value
    })
  }

  handleSubmit(event) {
    this.props.checkDogsSearchParams(this.state)
    event.preventDefault();
  }    

  render() {    
    return (
      <Form className={this.props.classes.form} onSubmit={this.handleSubmit} >
        <CardHeader style={{marginBottom: 15 + 'px'}} color="primary" className={this.props.classes.cardHeader} >
          <h4 style={{textAlign: 'center'}}>Фільтри</h4>
        </CardHeader>
        <Form.Group controlId="exampleForm.ControlSelect1">
          <Form.Label>Порода</Form.Label>
          <Form.Control as="select" name="breed" type="breed" value={this.state.breed} onChange={this.handleChange} >
            <option value="" >Оберіть породу</option>
            {this.state.params 
              ? this.state.params.breed.map(el => {
                return <option value={el.id} key={el.id}>{el.name}</option>
              })

              : null

            }
          </Form.Control>
        </Form.Group>
        <Form.Group controlId="exampleForm.ControlSelect1">
          <Form.Label>Місто</Form.Label>
          <Form.Control as="select" name="city" type="city" value={this.state.city} onChange={this.handleChange} >
            <option value="" >Оберіть місто</option>
            {this.state.params 
              ? this.state.params.city.map(el => {
                return <option value={el.id} key={el.id}>{el.name}</option>
              })

              : null

            }
          </Form.Control>
        </Form.Group>
        <Form.Group controlId="exampleForm.ControlSelect1">
          <Form.Label>Вік від</Form.Label>
          <Form.Control as="select" name="age_from" type="age_from" value={this.state.age_from} onChange={this.handleChange}>
            <option value="" >Оберіть вік</option>
            {this.state.params 
              ? this.state.params.age.map(el => {
                return <option value={el.id} key={el.id}>{el.years}</option>
              })

              : null

            }
          </Form.Control>
        </Form.Group>
        <Form.Group controlId="exampleForm.ControlSelect1">
          <Form.Label>Вік до</Form.Label>
          <Form.Control as="select" name="age_to" type="age_to" value={this.state.age_to} onChange={this.handleChange}>
            <option value="" >Оберіть вік</option>
            {this.state.params 
              ? this.state.params.age.map(el => {
                return <option value={el.id} key={el.id}>{el.years}</option>
              })

              : null

            }
          </Form.Control>
        </Form.Group>
        <CardFooter style={{display: 'flex', justifyContent: 'center'}} className={this.props.classes.cardFooter}>
          <Button color="primary" type="submit" disabled={this.props.animate ? true : false}>
            Шукати
          </Button>
          <LoopCircleLoading color='purple' style={this.props.animate ? {} : {display: "none"}} />
        </CardFooter>    
      </Form>
    ); 
  }   
}