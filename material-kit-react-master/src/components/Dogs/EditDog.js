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

export default class EditDog extends Component {
  constructor(props) {
    super(props);

    this.state = {
      name: "",
      breed: "",
      city: "",
      age: "",
      description: "",
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
        console.log('params', this.state.params)
      })
      .catch(error => console.log(error))

    axios.get(`http://localhost:3001/api/v1/dogs/${this.props.match.params.dogId}`)
      .then(response => {
          this.setState({
            dog: response.data.data.dog,
            name: response.data.data.dog.name,
            breed: response.data.data.dog.breed_id,
            city: response.data.data.dog.city_id,
            age: response.data.data.dog.age_id,
            description: response.data.data.dog.description
          })
          console.log('dog', this.state.dog)
      })
      .catch(error => console.log(error))
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
    axios.patch(`http://localhost:3000/api/v1/dogs/${this.props.match.params.dogId}`, {
      dog: {
        name: this.state.name,
        breed_id: this.state.breed,
        city_id: this.state.city,
        age_id: this.state.age,
        description: this.state.description
      }
    }, 
    {
      headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
      withCredentials: true
    }).then(response => {
      if(response.status === 200) {
        this.props.history.go(0)
      }
      this.setState({
        animate: false,
      })
      
    }).catch(error => {
      console.log('errors', error)
      this.setState({
        animate: false,
      })
    })
    event.preventDefault();
  }    

  render() {
    return (
      <Form className={this.props.classes.form} onSubmit={this.handleSubmit} >
      <CardHeader style={{marginBottom: 15 + 'px'}} color="primary" className={this.props.classes.cardHeader} >
        <h4 style={{textAlign: 'center'}}>Редагувати собаку</h4>
      </CardHeader>
        <Form.Group controlId="exampleForm.ControlInput1">
          <Form.Label>Ім'я</Form.Label>
          <Form.Control required name="name" type="name" value={this.state.name} onChange={this.handleChange} />
        </Form.Group>
        <Form.Group controlId="exampleForm.ControlSelect1">
          <Form.Label>Порода</Form.Label>
          <Form.Control as="select" required name="breed" type="breed" value={this.state.breed} onChange={this.handleChange} >
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
          <Form.Control as="select" required name="city" type="city" value={this.state.city} onChange={this.handleChange} >
            {this.state.params 
              ? this.state.params.city.map(el => {
                return <option value={el.id} key={el.id}>{el.name}</option>
              })

              : null

            }
          </Form.Control>
        </Form.Group>
        <Form.Group controlId="exampleForm.ControlSelect1">
          <Form.Label>Вік</Form.Label>
          <Form.Control as="select" required name="age" type="age" value={this.state.age} onChange={this.handleChange}>
            {this.state.params 
              ? this.state.params.age.map(el => {
                return <option value={el.id} key={el.id}>{el.years}</option>
              })

              : null

            }
          </Form.Control>
        </Form.Group>
        
        <Form.Group controlId="exampleForm.ControlTextarea1">
          <Form.Label>Опис</Form.Label>
          <Form.Control as="textarea" rows="3" name="description" type="description" value={this.state.description} onChange={this.handleChange} />
        </Form.Group>
        <CardFooter style={{display: 'flex', justifyContent: 'center'}} className={this.props.classes.cardFooter}>
          <Button color="primary" type="submit" disabled={this.state.animate ? true : false}>
            Підтвердити
          </Button>
          <LoopCircleLoading color='purple' style={this.state.animate ? {} : {display: "none"}} />
        </CardFooter>    
      </Form>
    )
  }
}