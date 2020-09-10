import React, { useEffect, useRef } from 'react';
import { makeStyles } from '@material-ui/core/styles';
import BottomNavigation from '@material-ui/core/BottomNavigation';
import BottomNavigationAction from '@material-ui/core/BottomNavigationAction';
import AccessTimeIcon from '@material-ui/icons/AccessTime';
import PetsOutlinedIcon from '@material-ui/icons/PetsOutlined';
import LocationCityIcon from '@material-ui/icons/LocationCity';
import DateRangeIcon from '@material-ui/icons/DateRange';
import GridContainer from 'components/Grid/GridContainer.js';
import GridItem from 'components/Grid/GridItem.js';
import styles from 'assets/jss/material-kit-react/views/landingPage.js';

const useStyles = makeStyles(styles);

export default function Sorting(props) {
  const classes = useStyles();
  const [value, setValue] = React.useState('created_at');
  return (
    <div className={classes.section}>
      <GridContainer justify="left">
        <GridItem xs={12} sm={12} md={9}>
          <BottomNavigation
            value={value}
            onChange={(event, newValue) => {
              setValue(newValue);
              props.handleSorting(newValue);
            }}
            showLabels
            className={classes.root}
          >
            <BottomNavigationAction
              value="created_at"
              label="Дата публікації"
              icon={<AccessTimeIcon />}
            />
            <BottomNavigationAction
              value="breed"
              label="Порода"
              icon={<PetsOutlinedIcon />}
            />
            <BottomNavigationAction
              value="city"
              label="Місто"
              icon={<LocationCityIcon />}
            />
            <BottomNavigationAction
              value="age"
              label="Вік"
              icon={<DateRangeIcon />}
            />
          </BottomNavigation>
        </GridItem>
        <GridItem
          xs={12}
          sm={12}
          md={3}
          style={{ textAlign: 'right' }}
        ></GridItem>
      </GridContainer>
    </div>
  );
}