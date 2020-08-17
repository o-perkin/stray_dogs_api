import React from "react";
// @material-ui/core components
import { makeStyles } from "@material-ui/core/styles";


// core components
import GridContainer from "components/Grid/GridContainer.js";
import GridItem from "components/Grid/GridItem.js";
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
      <GridContainer>
        <GridItem xs={12} sm={12} md={8}>
          <DogsList />
        </GridItem>
        <GridItem xs={12} sm={12} md={4}>
         
        </GridItem>
      </GridContainer>
    </div>
  );
}