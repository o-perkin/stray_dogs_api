/*eslint-disable*/
import React from "react";
import DeleteIcon from "@material-ui/icons/Delete";
import IconButton from "@material-ui/core/IconButton";
import { useHistory } from "react-router-dom";
// react components for routing our app without refresh
import { Link } from "react-router-dom";
import axios from 'axios';
// @material-ui/core components
import { makeStyles } from "@material-ui/core/styles";
import List from "@material-ui/core/List";
import ListItem from "@material-ui/core/ListItem";
import Tooltip from "@material-ui/core/Tooltip";

// @material-ui/icons
import { Apps, CloudDownload } from "@material-ui/icons";

// core components
import CustomDropdown from "components/CustomDropdown/CustomDropdown.js";
import Button from "components/CustomButtons/Button.js";

import styles from "assets/jss/material-kit-react/components/headerLinksStyle.js";

const useStyles = makeStyles(styles);

export default function HeaderLinks(props) {
  const classes = useStyles();
  const history = useHistory();

  const handleLogout = () => {
    axios.delete("http://localhost:3000/logout", {}, {
      headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
      withCredentials: true
    }).then(     
      localStorage.removeItem('token'),
      props.handleLogout(),
      history.push('/home')
    ).catch(error => {
      console.log("logout error", error)
    })
  }

  const handlelogoutClick = () =>{ 
    handleLogout();
  }

  if (props.loggedInStatus == "LOGGED_IN") {
    return (
      <List className={classes.list}>
        <ListItem className={classes.listItem}>
          <Button
            href="/"
            color="transparent"
            className={classes.navLink}
          >
            Головна
          </Button>
          <Button
            href="/dogs"
            color="transparent"
            className={classes.navLink}
          >
            Пошук собаки
          </Button>
          <Button
            href="/my_list"
            color="transparent"
            className={classes.navLink}
          >
            Мої собаки
          </Button>
          <Button
            href="/profile"
            color="transparent"
            className={classes.navLink}
          >
            Профіль
          </Button>
          <Button
            href="/favorites"
            color="transparent"
            className={classes.navLink}
          >
            Улюблені
          </Button>
          <Button
            href="/subscriptions"
            color="transparent"
            className={classes.navLink}
          >
            Підписки
          </Button>
          
          <Button
            color="transparent"
            className={classes.navLink}
            onClick={() => handlelogoutClick()}
          >
            Вийти
          </Button>
          
        </ListItem>
        <ListItem className={classes.listItem}>
          {/*<Tooltip title="Delete">
            <IconButton aria-label="Delete">
              <DeleteIcon />
            </IconButton>
          </Tooltip>*/}
          <Tooltip
            id="instagram-twitter"
            title="Follow us on twitter"
            placement={window.innerWidth > 959 ? "top" : "left"}
            classes={{ tooltip: classes.tooltip }}
          >
            <Button
              href="#"
              color="transparent"
              className={classes.navLink}
            >
              <i className={classes.socialIcons + " fab fa-twitter"} />
            </Button>
          </Tooltip>
        </ListItem>
        <ListItem className={classes.listItem}>
          <Tooltip
            id="instagram-facebook"
            title="Follow us on facebook"
            placement={window.innerWidth > 959 ? "top" : "left"}
            classes={{ tooltip: classes.tooltip }}
          >
            <Button
              color="transparent"
              href="#"
              className={classes.navLink}
            >
              <i className={classes.socialIcons + " fab fa-facebook"} />
            </Button>
          </Tooltip>
        </ListItem>
        <ListItem className={classes.listItem}>
          <Tooltip
            id="instagram-tooltip"
            title="Follow us on instagram"
            placement={window.innerWidth > 959 ? "top" : "left"}
            classes={{ tooltip: classes.tooltip }}
          >
            <Button
              color="transparent"
              href="#"
              className={classes.navLink}
            >
              <i className={classes.socialIcons + " fab fa-instagram"} />
            </Button>
          </Tooltip>
        </ListItem>
      </List>
    );
  } else {
    return (
      <List className={classes.list}>
        <ListItem className={classes.listItem}>
          <Button
            href="/"
            color="transparent"
            className={classes.navLink}
          >
            Головна
          </Button>
          <Button
            href="/dogs"
            color="transparent"
            className={classes.navLink}
          >
            Пошук собаки
          </Button>
          
          <Button
            href="/login"
            color="transparent"
            className={classes.navLink}
          >
            Увійти
          </Button>
          
          <Button
            href="/registration"
            color="transparent"
            className={classes.navLink}
          >
            Реєстрація
          </Button>
        </ListItem>
        <ListItem className={classes.listItem}>
          {/*<Tooltip title="Delete">
            <IconButton aria-label="Delete">
              <DeleteIcon />
            </IconButton>
          </Tooltip>*/}
          <Tooltip
            id="instagram-twitter"
            title="Follow us on twitter"
            placement={window.innerWidth > 959 ? "top" : "left"}
            classes={{ tooltip: classes.tooltip }}
          >
            <Button
              href="#"
              color="transparent"
              className={classes.navLink}
            >
              <i className={classes.socialIcons + " fab fa-twitter"} />
            </Button>
          </Tooltip>
        </ListItem>
        <ListItem className={classes.listItem}>
          <Tooltip
            id="instagram-facebook"
            title="Follow us on facebook"
            placement={window.innerWidth > 959 ? "top" : "left"}
            classes={{ tooltip: classes.tooltip }}
          >
            <Button
              color="transparent"
              href="#"
              className={classes.navLink}
            >
              <i className={classes.socialIcons + " fab fa-facebook"} />
            </Button>
          </Tooltip>
        </ListItem>
        <ListItem className={classes.listItem}>
          <Tooltip
            id="instagram-tooltip"
            title="Follow us on instagram"
            placement={window.innerWidth > 959 ? "top" : "left"}
            classes={{ tooltip: classes.tooltip }}
          >
            <Button
              color="transparent"
              href="#"
              className={classes.navLink}
            >
              <i className={classes.socialIcons + " fab fa-instagram"} />
            </Button>
          </Tooltip>
        </ListItem>
      </List>

    )
  }
  
}
