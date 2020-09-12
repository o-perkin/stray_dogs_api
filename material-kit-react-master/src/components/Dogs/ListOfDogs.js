import React, { useEffect, useRef } from 'react';
import { makeStyles } from '@material-ui/core/styles';
import styles from 'assets/jss/material-kit-react/views/landingPage.js';
import GridContainer from 'components/Grid/GridContainer.js';
import GridItem from 'components/Grid/GridItem.js';
import Pagination from '@material-ui/lab/Pagination';
import DogCard from 'components/Dogs/DogCard.js';
import Sorting from 'components/Sorting/Sorting.js';
import FiltersForm from 'components/Filters/FiltersForm.js';
import Button from 'components/CustomButtons/Button.js';
import AddBoxIcon from '@material-ui/icons/AddBox';

const useStyles = makeStyles(styles);

export default function ListOfDogs(props) {

  const classes = useStyles();

  return (
    <div className={classes.section}>
      <GridContainer>
        <GridItem xs={12} sm={12} md={8}>
          <div>
            <Sorting handleSorting={props.handleSorting} />                  
            <Pagination
              style={{ marginTop: '50px' }}
              count={props.dogs.number_of_pages}
              size="large"
              onChange={props.handlePaginations}
              page={props.latestPage.current}
            />
            {props.dogs.dogs
              ? props.dogs.dogs.map((dog) => {
                  return (
                    <div key={dog.id}>
                      <br />
                      <br />
                      <DogCard
                        updateFavoriteState={props.updateFavoriteState}
                        current_user={props.current_user}
                        loggedInStatus={props.loggedInStatus}
                        {...props}
                        createNotification={props.createNotification}
                        dog={dog}
                      />
                      <br />
                    </div>
                  );
                })
              : null}
          </div>
        </GridItem>

        <GridItem xs={12} sm={12} md={4}>
          {props.loggedInStatus == 'LOGGED_IN' ? (
            <Button
              variant="contained"
              color="primary"
              style={{
                marginLeft: 'auto',
                marginTop: '8px',
                float: 'right'
              }}
              href="/dogs/new"
              className={classes.button}
              startIcon={<AddBoxIcon />}
            >
              Додати собаку
            </Button>
          ) : null}
          <FiltersForm
            handleFilters={props.handleFilters}
            animate={props.animate}
            {...props}
            classes={classes}
          />
        </GridItem>
      </GridContainer>

      <Pagination
        style={{ marginTop: '20px', marginBottom: '20px' }}
        count={props.dogs.number_of_pages}
        size="large"
        onChange={props.handlePaginations}
        page={props.latestPage.current}
      />
    </div>
  );
}