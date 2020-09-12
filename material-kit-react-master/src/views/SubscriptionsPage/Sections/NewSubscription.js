import React from "react";
import { Redirect } from "react-router-dom";
import { makeStyles } from "@material-ui/core/styles"; 
import InputLabel from '@material-ui/core/InputLabel';
import FormHelperText from '@material-ui/core/FormHelperText';
import FormControl from '@material-ui/core/FormControl';
import Select from '@material-ui/core/Select';
import NativeSelect from '@material-ui/core/NativeSelect';
import { Form } from 'react-bootstrap';
import CardHeader from "components/Card/CardHeader.js";
import CardFooter from "components/Card/CardFooter.js";
import Button from "components/CustomButtons/Button.js";
import Subscription from "components/Subscriptions/Subscription.js";
import { LoopCircleLoading } from 'react-loadingg';
import axios from 'axios';

import styles from "assets/jss/material-kit-react/views/landingPage.js";

const dashboardRoutes = [];

const useStyles = makeStyles();

export default function NewSubscription(props) {
  const classes = useStyles();
  const { ...rest } = props;
  const [subscriptions, setsubscriptions] = React.useState([1]);
  const [state, setState] = React.useState({
    "0": {
      breed: '',
      city: '',
      age_from: '',
      age_to: ''
    }
  });

  function addSubscription() {
    setsubscriptions(subscriptions.concat([subscriptions.length + 1]))
  }

  function removeSubscription(id) {
    setState({
      ...state,
      [`${id}`]: undefined 
    })
    setsubscriptions(subscriptions.splice(0, (subscriptions.length - 1)))
  }

  function handleSubmit(event) {
    axios.post("http://localhost:3000/api/v1/subscribes", {
      subscribe: {
        subscriptions_attributes: state          
      }
    }, 
    {
      headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
      withCredentials: true
    }).then(response => {
      if(response.status === 200) {
        props.history.push('/subscribes')
      }      
    }).catch(error => {
      console.log('errors', error)
    })
    event.preventDefault();
  }

  if (props.loggedInStatus == 'LOGGED_IN') {
    return (
      <Form className={classes.form} onSubmit={handleSubmit} >
        <CardHeader color="primary" className={classes.cardHeader} >
          <h4 style={{textAlign: 'center'}}>Створити підписку</h4>
        </CardHeader>
        {
          subscriptions.map((x) => {
            return <Subscription setState={setState} state={state} last={subscriptions.length} id={x} addSubscription={addSubscription} removeSubscription={removeSubscription} /> 
          })
        } 
        <CardFooter style={{display: 'flex', justifyContent: 'center'}} className={classes.cardFooter}>
          <Button color="primary" type="submit">
            Підтвердити
          </Button>
        </CardFooter>    
      </Form>   
    );
  } else {
    return <Redirect to='/login' />
  }  
}