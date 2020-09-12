import React, { useEffect } from 'react';
import { Redirect } from "react-router-dom";
import classNames from "classnames";
import { makeStyles } from "@material-ui/core/styles"; 
import Header from "components/Header/Header.js";
import Footer from "components/Footer/Footer.js";
import GridContainer from "components/Grid/GridContainer.js";
import GridItem from "components/Grid/GridItem.js";
import Button from "components/CustomButtons/Button.js";
import HeaderLinks from "components/Header/HeaderLinks.js";
import Parallax from "components/Parallax/Parallax.js";
import NewSubscription from "./Sections/NewSubscription.js";
import axios from 'axios';

import styles from "assets/jss/material-kit-react/views/landingPage.js";

const dashboardRoutes = [];

const useStyles = makeStyles(styles);

export default function SubscriptionsPage(props) {
  const classes = useStyles();
  const { ...rest } = props;
  const [subscribes, setSubscribes] = React.useState([]);

  useEffect(() => {
    axios
      .get(`http://localhost:3001/api/v1/subscribes`, {
        headers: {
          Accept: '*/*',
          Authorization: localStorage.getItem('token')
        },
        withCredentials: true
      })
      .then((response) => {
        setSubscribes(response.data.data);
      })
      .catch((error) => console.log(error));
  }, []);

  if (props.loggedInStatus == 'LOGGED_IN') {
    return (
      <div>
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
        <Parallax small filter image={require("assets/img/landing-bg.jpg")} />
        <div className={classNames(classes.main, classes.mainRaised)}>
          <div className={classes.container}>
            {subscribes 
              ? <div style={{color: 'black'}}>
                  ALl Subscroptions
                </div>
              : <NewSubscription {...props} loggedInStatus={props.loggedInStatus} />
            }
          </div>
        </div>
        <Footer />
      </div>
    );
  } else {
    return <Redirect to='/login' />
  }  
}
