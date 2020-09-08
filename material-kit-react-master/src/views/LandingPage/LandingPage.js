import React, { useState, useEffect, useRef } from "react";
// nodejs library that concatenates classes
import classNames from "classnames";
// @material-ui/core components
import { makeStyles } from "@material-ui/core/styles"; 
import {NotificationContainer} from 'react-notifications';
import BottomNavigation from '@material-ui/core/BottomNavigation';
import BottomNavigationAction from '@material-ui/core/BottomNavigationAction';
import Pagination from "@material-ui/lab/Pagination";
import DogCard from 'components/Dogs/DogCard.js';
import FiltersForm from "components/Filters/FiltersForm.js";
import axios from 'axios';

import AccessTimeIcon from '@material-ui/icons/AccessTime';
import PetsOutlinedIcon from '@material-ui/icons/PetsOutlined';
import LocationCityIcon from '@material-ui/icons/LocationCity';
import DateRangeIcon from '@material-ui/icons/DateRange';
import AddBoxIcon from '@material-ui/icons/AddBox';
// @material-ui/icons

// core components
import Header from "components/Header/Header.js";
import Footer from "components/Footer/Footer.js";
import GridContainer from "components/Grid/GridContainer.js";
import GridItem from "components/Grid/GridItem.js";
import Button from "components/CustomButtons/Button.js";
import HeaderLinks from "components/Header/HeaderLinks.js";
import Parallax from "components/Parallax/Parallax.js";

import styles from "assets/jss/material-kit-react/views/landingPage.js";

const dashboardRoutes = [];

const useStyles = makeStyles(styles);

export default function LandingPage(props) {
  const classes = useStyles();
  const { ...rest } = props;
  const [value, setValue] = React.useState(0);
  const [page, setPage] = React.useState(1);
  const [dogs, setDogs] = React.useState([]);
  const [filters, setFilters] = React.useState({
    breed: '',
    city: '',
    age_from: '',
    age_to: ''
  });
  const [sorting, setSorting] = React.useState({
    sort: 'created_at',
    direction: 'desc'
  })
  const latestPage = useRef(page);
  const latestFilters = useRef(filters);
  const latestSorting = useRef(sorting);

  useEffect(() => {
    axios.get(`http://localhost:3001/api/v1/dogs`)
    .then(response => {
      setDogs(response.data.data)
    }).catch(error => console.log(error))
  }, []);

  function loadDogs() {
    axios.get(`http://localhost:3001/api/v1/dogs?page=${latestPage.current}&breed=${latestFilters.current.breed}&city=${latestFilters.current.city}&age_from=${latestFilters.current.age_from}&age_to=${latestFilters.current.age_to}&sort=${latestSorting.current.sort}&direction=${latestSorting.current.direction}`)
    .then(response => {
      console.log("asdasdasd", response)
      setDogs(response.data.data)
    }).catch(error => console.log(error))
  }
  
  const handleChange = (event, value) => {
    latestPage.current = value;
    loadDogs();
  };

  function handleFilters(value) {
    latestFilters.current = value;
    loadDogs();
  }

  function handleSorting(value) {
    latestSorting.current = value;
    loadDogs();
  } 

  function updateFavoriteState(id) {
    this.setState({
      dogs: this.state.dogs.map(dog => {
        (dog.id == id && dog.favorite == true) ? dog.favorite = false : dog.favorite = true
        return dog
      })
    })
  }
  return (
    <div>
      <NotificationContainer/>
      <Header
        color="transparent"
        routes={dashboardRoutes}
        brand="Material Kit React"
        rightLinks={<HeaderLinks {...props} handleLogout={props.handleLogout} loggedInStatus={props.loggedInStatus} />}
        fixed
        changeColorOnScroll={{
          height: 400,
          color: "white"
        }}
        {...rest}
      />
      <Parallax filter image={require("assets/img/landing-bg.jpg")}>
        <div className={classes.container}>
          <GridContainer>
            <GridItem xs={12} sm={12} md={6}>
              <h1 className={classes.title}>Your Story Starts With Us.</h1>
              <h4>
                Every landing page needs a small description after the big bold
                title, that{"'"}s why we added this text here. Add here all the
                information that can make you or your product create the first
                impression.
              </h4>
              <br />
              <Button
                color="danger"
                size="lg"
                href="https://www.youtube.com/watch?v=dQw4w9WgXcQ&ref=creativetim"
                target="_blank"
                rel="noopener noreferrer"
              >
                <i className="fas fa-play" />
                Watch video
              </Button>
            </GridItem>
          </GridContainer>
        </div>
      </Parallax>
      <div className={classNames(classes.main, classes.mainRaised)}>
        <div className={classes.container} >
          <br />          
          <div className={classes.section}>
            <GridContainer justify="left">
              <GridItem xs={12} sm={12} md={8}>
                  <BottomNavigation
                    value={value}
                    onChange={(event, newValue) => {
                      setValue(newValue);
                    }}
                    showLabels
                    className={classes.root}
                  >
                    <BottomNavigationAction onClick={handleSorting('date')} label="Дата публікації" icon={<AccessTimeIcon />} />
                    <BottomNavigationAction label="Порода" icon={<PetsOutlinedIcon />} />
                    <BottomNavigationAction label="Місто" icon={<LocationCityIcon />} />
                    <BottomNavigationAction label="Вік" icon={<DateRangeIcon />} />
                  </BottomNavigation>  
              </GridItem>
              <GridItem xs={12} sm={12} md={4} style={{textAlign: 'right'}}>
                {props.current_user.roles == "site_admin" ? 
                  <Button
                    variant="contained"
                    color="primary"
                    style={{marginLeft: 'auto', marginTop: '8px'}}
                    href="/dogs/new"
                    className={classes.button}
                    startIcon={<AddBoxIcon />}
                  >
                    Додати собаку
                  </Button>
                  : null
                }
              </GridItem>
            </GridContainer>
          </div>
            <div className={classes.section}>
              <Pagination style={{marginTop: '50px'}} count={dogs.number_of_pages}  size="large" onChange={handleChange} page={latestPage.current} />
                <GridContainer>
                  <GridItem xs={12} sm={12} md={8}>          
                    <div>
                         {dogs.dogs
                          ? dogs.dogs.map(el => { 
                          return (
                            <div key={el.id}>                
                              <br />
                              <br />
                              <DogCard updateFavoriteState={updateFavoriteState} current_user={props.current_user} loggedInStatus={props.loggedInStatus} {...props} createNotification={props.createNotification} dog={el} /> 
                              <br />   
                            </div>           
                          )
                         }) 
                          : null
                        }                                         
                    </div>
                  </GridItem>
                  <GridItem xs={12} sm={12} md={4} style={{marginTop: '90px'}} >
                    <FiltersForm handleFilters={handleFilters} animate={props.animate} checkDogsSearchParams={props.checkDogsSearchParams} {...props} classes={classes} />
                  </GridItem>
                </GridContainer>
              <Pagination style={{marginTop: '20px', marginBottom: '20px'}} count={dogs.number_of_pages} size="large" onChange={handleChange} page={latestPage.current} />
            </div>
          <br />
        </div>
      </div>
      <Footer />
    </div>
  );
}
