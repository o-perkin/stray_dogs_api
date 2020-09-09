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
  const [value, setValue] = React.useState('created_at');
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
    axios.get(`http://localhost:3001/api/v1/dogs`, {
      headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
      withCredentials: true
    })
    .then(response => {
      setDogs(response.data.data);
      console.log('ASDASD', response.data.data)
    }).catch(error => console.log(error))
  }, []);

  function loadDogs() {
    axios.get(`http://localhost:3001/api/v1/dogs?page=${latestPage.current}&breed=${latestFilters.current.breed}&city=${latestFilters.current.city}&age_from=${latestFilters.current.age_from}&age_to=${latestFilters.current.age_to}&sort=${latestSorting.current.sort}&direction=${latestSorting.current.direction}`, {
      headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
      withCredentials: true
    })
    .then(response => {
      console.log("asdasdasd", response.data.data)
      setDogs(response.data.data)
    }).catch(error => console.log(error))
  }
  
  const handlePaginations = (event, value) => {
    latestPage.current = value;
    loadDogs();
  };

  function handleFilters(value) {
    latestFilters.current = value;
    loadDogs();
  }

  function handleSorting(value) {
    latestSorting.current.sort != value || latestSorting.current.direction == 'asc'
     ? latestSorting.current.direction = 'desc' 
     : latestSorting.current.direction = 'asc' ;
     latestSorting.current.sort = value;
     loadDogs();
  } 

  function updateFavoriteState(id) {
    let asd = dogs.dogs.map(dog => {
      if (dog.id == id && dog.favorite) {
        dog.favorite = false
      } else if (dog.id == id && !dog.favorite) {
        dog.favorite = true
      }
      return dog
    })
    setDogs({dogs: asd, number_of_pages: dogs.number_of_pages})
  }
  return (
    <div>
      <NotificationContainer/>
      <Header
        color="transparent"
        routes={dashboardRoutes}
        rightLinks={<HeaderLinks {...props} handleLogout={props.handleLogout} loggedInStatus={props.loggedInStatus} />}
        fixed
        changeColorOnScroll={{
          height: 400,
          color: "white"
        }}
        {...rest}
      />
      <Parallax small filter image={require("assets/img/dogs-park.jpg")} />
      <div className={classNames(classes.main, classes.mainRaised)}>
        <div className={classes.container} >
          <br /> 

          

          {/* Start of list of Dogs */} 
          <div className={classes.section}>
            

              <GridContainer>

                <GridItem xs={12} sm={12} md={8}>          
                  <div>
                    {/* Start of Sorting section */} 

                    <div className={classes.section}>
                      <GridContainer justify="left" >
                        <GridItem xs={12} sm={12} md={9}>
                            <BottomNavigation
                              value={value}
                              onChange={(event, newValue) => {
                                setValue(newValue);
                                handleSorting(newValue);
                              }}
                              showLabels
                              className={classes.root}
                            >
                              <BottomNavigationAction value='created_at' label="Дата публікації" icon={<AccessTimeIcon />} />
                              <BottomNavigationAction value='breed' label="Порода" icon={<PetsOutlinedIcon />} />
                              <BottomNavigationAction value='city' label="Місто" icon={<LocationCityIcon />} />
                              <BottomNavigationAction value='age' label="Вік" icon={<DateRangeIcon />} />
                            </BottomNavigation>  
                        </GridItem>
                        <GridItem xs={12} sm={12} md={3} style={{textAlign: 'right'}}>
                          
                        </GridItem>
                      </GridContainer>
                    </div>
                    {/* End of Sorting section */} 
                    <Pagination style={{marginTop: '50px'}} count={dogs.number_of_pages}  size="large" onChange={handlePaginations} page={latestPage.current} />
                    {dogs.dogs ? dogs.dogs.map(dog => {                         
                        return (
                          <div key={dog.id}>                
                            <br />
                            <br />
                            <DogCard updateFavoriteState={updateFavoriteState} current_user={props.current_user} loggedInStatus={props.loggedInStatus} {...props} createNotification={props.createNotification} dog={dog} /> 
                            <br />   
                          </div>           
                        )
                      }) 
                      : null
                    }                                         
                  </div>
                </GridItem>

                <GridItem xs={12} sm={12} md={4} >
                  {props.current_user.roles == "site_admin" ? 
                      <Button
                        variant="contained"
                        color="primary"
                        style={{marginLeft: 'auto', marginTop: '8px', float: 'right'}}
                        href="/dogs/new"
                        className={classes.button}
                        startIcon={<AddBoxIcon />}
                      >
                        Додати собаку
                      </Button>
                      : null
                    }
                  <FiltersForm handleFilters={handleFilters} animate={props.animate} checkDogsSearchParams={props.checkDogsSearchParams} {...props} classes={classes} />
                </GridItem>
              </GridContainer>

            <Pagination style={{marginTop: '20px', marginBottom: '20px'}} count={dogs.number_of_pages} size="large" onChange={handlePaginations} page={latestPage.current} />
          </div>
          {/* End of list of Dogs */} 

          <br />
        </div>
      </div>
      <Footer />
    </div>
  );
}
