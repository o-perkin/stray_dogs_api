import React from "react";
import { Redirect } from "react-router-dom";
import axios from 'axios';
import {NotificationContainer} from 'react-notifications';
// nodejs library that concatenates classes
import classNames from "classnames";
// @material-ui/core components
import { makeStyles } from "@material-ui/core/styles";
import { red } from '@material-ui/core/colors';
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
import styles from "assets/jss/material-kit-react/views/profilePage.js";
import { useHistory } from "react-router-dom";

import DogMainCard from "components/Dogs/DogMainCard.js";


const useStyles = makeStyles((theme) => ({
  root: {
    maxWidth: 900,
  },
  media: {
    height: 0,
    paddingTop: '56.25%', // 16:9
  },
  expand: {
    transform: 'rotate(0deg)',
    marginLeft: 'auto',
    transition: theme.transitions.create('transform', {
      duration: theme.transitions.duration.shortest,
    }),
  },
  expandOpen: {
    transform: 'rotate(180deg)',
  },
  avatar: {
    backgroundColor: red[500],
  },
  button: {
    margin: theme.spacing(1),
  },
}));

export default function DogsShowPage(props) {
  

  const classes = useStyles();
  const [expanded, setExpanded] = React.useState(false);

  const handleExpandClick = () => {
    setExpanded(!expanded);
  };
  const history = useHistory();

  const [cardAnimaton, setCardAnimation] = React.useState("cardHidden");
  setTimeout(function() {
    setCardAnimation("");
  }, 700);
  const { ...rest } = props;
  const imageClasses = classNames(
    classes.imgRaised,
    classes.imgRoundedCircle,
    classes.imgFluid
  );
  const navImageClasses = classNames(classes.imgRounded, classes.imgGallery);

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
              <GridItem xs={12} sm={12} md={6} >
                <DogMainCard createNotification={props.createNotification} {...props} classes={classes} handleExpandClick={handleExpandClick} expanded={expanded} loggedInStatus={props.loggedInStatus} />
              </GridItem>
            </GridContainer>
          </div>
        </div>
      </div>
      <Footer />
    </div>
  );
}
