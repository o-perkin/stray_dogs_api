import React from "react";
// @material-ui/core components
import { makeStyles } from "@material-ui/core/styles";
import BottomNavigation from '@material-ui/core/BottomNavigation';
import BottomNavigationAction from '@material-ui/core/BottomNavigationAction';
import AccessTimeIcon from '@material-ui/icons/AccessTime';
import PetsOutlinedIcon from '@material-ui/icons/PetsOutlined';
import LocationCityIcon from '@material-ui/icons/LocationCity';
import DateRangeIcon from '@material-ui/icons/DateRange';
// @material-ui/icons
import Chat from "@material-ui/icons/Chat";
import VerifiedUser from "@material-ui/icons/VerifiedUser";
import Fingerprint from "@material-ui/icons/Fingerprint";

// core components
import GridContainer from "components/Grid/GridContainer.js";
import GridItem from "components/Grid/GridItem.js";
import InfoArea from "components/InfoArea/InfoArea.js";
import DogsList from "components/Dogs/DogsList.js";

import styles from "assets/jss/material-kit-react/views/landingPageSections/productStyle.js";

const useStyles = makeStyles({
  root: {
    width: 500,
  },
});

export default function SortingSection() {

  const classes = useStyles();
  const [value, setValue] = React.useState('recents');

  const handleChange = (event, newValue) => {
    setValue(newValue);
  };
  return (
    <div className={classes.section}>
      <GridContainer justify="center">
        <GridItem xs={12} sm={12} md={8}>
          <BottomNavigation value={value} onChange={handleChange} className={classes.root}>
            <BottomNavigationAction label="Date" value="date" icon={<AccessTimeIcon />} />
            <BottomNavigationAction label="Breed" value="breed" icon={<PetsOutlinedIcon />} />
            <BottomNavigationAction label="City" value="city" icon={<LocationCityIcon />} />
            <BottomNavigationAction label="Age" value="age" icon={<DateRangeIcon />} />
          </BottomNavigation>
        </GridItem>
      </GridContainer>
    </div>
  );
}
