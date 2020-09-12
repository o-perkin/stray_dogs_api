import React, { useEffect, useRef } from "react";
import { Redirect } from "react-router-dom";
import { makeStyles } from "@material-ui/core/styles"; 
import InputLabel from '@material-ui/core/InputLabel';
import FormHelperText from '@material-ui/core/FormHelperText';
import FormControl from '@material-ui/core/FormControl';
import Select from '@material-ui/core/Select';
import NativeSelect from '@material-ui/core/NativeSelect';
import styles from "assets/jss/material-kit-react/views/landingPage.js";
import AddCircleOutlineIcon from '@material-ui/icons/AddCircleOutline';
import IconButton from '@material-ui/core/IconButton';
import RemoveCircleOutlineIcon from '@material-ui/icons/RemoveCircleOutline';
import axios from 'axios';

const dashboardRoutes = [];

const useStyles = makeStyles((theme) => ({
  formControl: {
    margin: theme.spacing(1),
    minWidth: 120,
  },
  selectEmpty: {
    marginTop: theme.spacing(2),
  },
}));

export default function Subscription(props) {
  const classes = useStyles();
  const { ...rest } = props;
  const [dogParams, setDogParams] = React.useState({
    breed: {},
    city: {},
    age: {}
  });

  const [state, setState] = React.useState({
    breed: '',
    city: '',
    age_from: '',
    age_to: ''
  });
  const latestState = useRef(state);

  useEffect(() => {
    axios
      .get(`http://localhost:3001/api/v1/new_dog.json`, {
        headers: {
          Accept: '*/*',
          Authorization: localStorage.getItem('token')
        },
        withCredentials: true
      })
      .then((response) => {
        setDogParams(response.data.data);
      })
      .catch((error) => console.log(error));
  }, []);

  const handleChange = (event) => {
    const name = event.target.name;
    latestState.current = {
      ...latestState.current,
      [name]: event.target.value,
    };
    props.setState({
      ...props.state,
      [`${props.id - 1}`]: latestState.current,
    })
  };

  function removeSubscription() {
    props.removeSubscription(props.id - 1)
  }

  return (
    <div style={{display: 'flex'}} key={props.id} id={props.id}>
      <FormControl required="true" className={classes.formControl}>
        <InputLabel htmlFor="breed-native-simple">Порода</InputLabel>
        <Select
          native
          value={latestState.current.breed}
          onChange={handleChange}
          inputProps={{
            name: 'breed',
            id: 'breed-native-simple',
          }}
        >
          <option aria-label="None" value="" />
          { 
            Object.keys(dogParams.breed).map(k => {
              return <option value={dogParams.breed[k]} key={dogParams.breed[k]}>{k}</option>
            })
          }
        </Select>
      </FormControl>
      <FormControl required="true" className={classes.formControl}>
        <InputLabel htmlFor="city-native-simple">Місто</InputLabel>
        <Select
          native
          value={latestState.current.city}
          onChange={handleChange}
          inputProps={{
            name: 'city',
            id: 'city-native-simple',
          }}
        >
          <option aria-label="None" value="" />
          { 
            Object.keys(dogParams.city).map(k => {
              return <option value={dogParams.city[k]} key={dogParams.city[k]}>{k}</option>
            })
          }
        </Select>
      </FormControl>
      <FormControl required="true" className={classes.formControl}>
        <InputLabel htmlFor="age-from-native-simple">Вік від</InputLabel>
        <Select
          native
          value={latestState.current.age_from}
          onChange={handleChange}
          inputProps={{
            name: 'age_from',
            id: 'age-from-native-simple',
          }}
        >
          <option aria-label="None" value="" />
          { 
            Object.keys(dogParams.age).map(k => {
              return <option value={dogParams.age[k]} key={dogParams.age[k]}>{k}</option>
            })
          }
        </Select>
      </FormControl>
      <FormControl required="true" className={classes.formControl}>
        <InputLabel htmlFor="age-to-native-simple">Вік до</InputLabel>
        <Select
          native
          value={latestState.current.age_to}
          onChange={handleChange}
          inputProps={{
            name: 'age_to',
            id: 'age-to-native-simple',
          }}
        >
          <option aria-label="None" value="" />
          { 
            Object.keys(dogParams.age).map(k => {
              return <option value={dogParams.age[k]} key={dogParams.age[k]}>{k}</option>
            })
          }
        </Select>
      </FormControl>
      {props.last == props.id && props.last < 3
        ? <IconButton 
            style={{marginTop: '15px', marginLeft: '15px'}} 
            onClick={props.addSubscription} 
          >      
            <AddCircleOutlineIcon color="primary" />
          </IconButton>
        : null}

      {props.last == props.id && props.id != 1
        ? <IconButton 
            style={{marginTop: '15px'}} 
            onClick={removeSubscription} 
          >      
            <RemoveCircleOutlineIcon color="primary" />
          </IconButton>
        : null}
    </div>  
  );
}