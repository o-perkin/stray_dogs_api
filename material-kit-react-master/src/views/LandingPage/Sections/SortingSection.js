import React from "react";
// @material-ui/core components
import { makeStyles } from "@material-ui/core/styles";
import { ButtonGroup } from '@material-ui/core';
import BottomNavigation from '@material-ui/core/BottomNavigation';
import BottomNavigationAction from '@material-ui/core/BottomNavigationAction';
import ArrowDropUpIcon from '@material-ui/icons/ArrowDropUp';
import AccessTimeIcon from '@material-ui/icons/AccessTime';
import PetsOutlinedIcon from '@material-ui/icons/PetsOutlined';
import LocationCityIcon from '@material-ui/icons/LocationCity';
import DateRangeIcon from '@material-ui/icons/DateRange';
import Button from '@material-ui/core/Button';
import AddBoxIcon from '@material-ui/icons/AddBox';
// core components
import GridContainer from "components/Grid/GridContainer.js";
import GridItem from "components/Grid/GridItem.js";

import styles from "assets/jss/material-kit-react/views/landingPageSections/productStyle.js";


import { emphasize, withStyles } from '@material-ui/core/styles';
import Breadcrumbs from '@material-ui/core/Breadcrumbs';
import Chip from '@material-ui/core/Chip';
import HomeIcon from '@material-ui/icons/Home';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';

const useStyles = makeStyles({
  root: {
    width: 500,
  },
});

export default function SortingSection(props) {

  const classes = useStyles();
  const [value, setValue] = React.useState(0);

  return (
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
              <BottomNavigationAction label="Дата публікації" icon={<AccessTimeIcon />} />
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
  );
}
