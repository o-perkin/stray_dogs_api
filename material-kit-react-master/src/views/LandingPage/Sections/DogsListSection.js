import React from "react";
// @material-ui/core components
import { makeStyles } from "@material-ui/core/styles";



// core components
import GridContainer from "components/Grid/GridContainer.js";
import GridItem from "components/Grid/GridItem.js";
import DogsList from "components/Dogs/DogsList.js";
import FiltersForm from "components/Filters/FiltersForm.js";

import styles from "assets/jss/material-kit-react/views/landingPageSections/productStyle.js";

const useStyles = makeStyles({
  root: {
    width: 500,
  },
});

export default function DogsListSection(props) {
  
  const classes = useStyles();
  const [value, setValue] = React.useState('recents');

  const handleChange = (event, newValue) => {
    setValue(newValue);
  };
  return (
    <div className={classes.section}>
      <GridContainer>
        <GridItem xs={12} sm={12} md={8}>          
          <DogsList current_user={props.current_user} loggedInStatus={props.loggedInStatus} {...props} createNotification={props.createNotification} />
        </GridItem>
        <GridItem xs={12} sm={12} md={4} style={{marginTop: '90px'}} >
          <FiltersForm {...props} classes={classes} />
        </GridItem>
      </GridContainer>
    </div>
  );
}