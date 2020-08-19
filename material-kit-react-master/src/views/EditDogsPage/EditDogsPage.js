import React from "react";
import { Redirect } from "react-router-dom";
import axios from 'axios';
import {NotificationContainer} from 'react-notifications';
// nodejs library that concatenates classes
import classNames from "classnames";
// @material-ui/core components
import { makeStyles } from "@material-ui/core/styles";
// @material-ui/icons
import Camera from "@material-ui/icons/Camera";
import Palette from "@material-ui/icons/Palette";
import Favorite from "@material-ui/icons/Favorite";
// core components
import Header from "components/Header/Header.js";
import Footer from "components/Footer/Footer.js";
import Button from "components/CustomButtons/Button.js";
import GridContainer from "components/Grid/GridContainer.js";
import GridItem from "components/Grid/GridItem.js";
import HeaderLinks from "components/Header/HeaderLinks.js";
import NavPills from "components/NavPills/NavPills.js";
import Parallax from "components/Parallax/Parallax.js";

import profile from "assets/img/faces/christian.jpg"; 

import studio1 from "assets/img/examples/studio-1.jpg";
import studio2 from "assets/img/examples/studio-2.jpg";
import studio3 from "assets/img/examples/studio-3.jpg";
import studio4 from "assets/img/examples/studio-4.jpg";
import studio5 from "assets/img/examples/studio-5.jpg";
import work1 from "assets/img/examples/olu-eletu.jpg";
import work2 from "assets/img/examples/clem-onojeghuo.jpg";
import work3 from "assets/img/examples/cynthia-del-rio.jpg";
import work4 from "assets/img/examples/mariya-georgieva.jpg";
import work5 from "assets/img/examples/clem-onojegaw.jpg";

import styles from "assets/jss/material-kit-react/views/profilePage.js";


import InputAdornment from "@material-ui/core/InputAdornment";
import Icon from "@material-ui/core/Icon"; 

// @material-ui/icons
import Email from "@material-ui/icons/Email";
import People from "@material-ui/icons/People";
import Card from "components/Card/Card.js";
import CardBody from "components/Card/CardBody.js";
import CardHeader from "components/Card/CardHeader.js";
import CardFooter from "components/Card/CardFooter.js";
import CustomInput from "components/CustomInput/CustomInput.js";
import EditDog from "components/Dogs/EditDog.js";
import { useHistory } from "react-router-dom";


const useStyles = makeStyles(styles);

export default function NewDogsPage(props) {
  const history = useHistory();

  const [cardAnimaton, setCardAnimation] = React.useState("cardHidden");
  setTimeout(function() {
    setCardAnimation("");
  }, 700);
  const classes = useStyles();
  const { ...rest } = props;
  const imageClasses = classNames(
    classes.imgRaised,
    classes.imgRoundedCircle,
    classes.imgFluid
  );
  const navImageClasses = classNames(classes.imgRounded, classes.imgGallery);

  const deleteAccount = (event) => {
    axios.delete("http://localhost:3000/", 
    {
      headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
      withCredentials: true
    }).then(response => {
      if(response.status === 200) {
        props.handleLogout();
        history.push('/');
      }
      console.log("response", response);
      
    }).catch(error => {
      console.log("delete account errors", error);
    })

    event.preventDefault();
  }

  if (props.loggedInStatus == 'LOGGED_IN') {
    return (
      <div>
        <Header
          color="transparent"
          brand="Material Kit React"
          rightLinks={<HeaderLinks {...props} handleLogout={props.handleLogout} loggedInStatus={props.loggedInStatus} />}
          fixed
          changeColorOnScroll={{
            height: 200,
            color: "white"
          }}
          {...rest}
        />
        <NotificationContainer/>
        <Parallax small filter image={require("assets/img/profile-bg.jpg")} />
        <div className={classNames(classes.main, classes.mainRaised)}>
          <div>
            <div className={classes.container}>
              <GridContainer justify="center">
                <GridItem xs={12} sm={12} md={6}>
                  <div className={classes.profile}>
                    
            
                  </div>
                </GridItem>
              </GridContainer>
              <GridContainer justify="center">
                <GridItem xs={12} sm={12} md={6} >
                  <Card style={{paddingLeft: 30 + 'px', paddingRight: 30 + 'px', paddingTop: 20 + 'px'}}>
                    <EditDog {...props} createNotification={props.createNotification}  history={history} state={props.state} classes={classes} />
                  </Card>
                </GridItem>
              </GridContainer>
            </div>
          </div>
        </div>
        <Footer />
      </div>
    );
  } else {
    return <Redirect to='/login' />
  }  
}
