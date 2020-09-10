import React, { useEffect, useRef } from 'react';
import classNames from 'classnames';
import { makeStyles } from '@material-ui/core/styles';
import { NotificationContainer } from 'react-notifications';
import axios from 'axios';
import Header from 'components/Header/Header.js';
import Footer from 'components/Footer/Footer.js';
import HeaderLinks from 'components/Header/HeaderLinks.js';
import Parallax from 'components/Parallax/Parallax.js';
import styles from 'assets/jss/material-kit-react/views/landingPage.js';
import ListOfDogs from 'components/Dogs/ListOfDogs.js';

const dashboardRoutes = [];

const useStyles = makeStyles(styles);

export default function DogsPage(props) {
  const classes = useStyles();
  const { ...rest } = props;
  const [page, setPage] = React.useState(1);
  const [dogs, setDogs] = React.useState([]);
  const [filters, setFilters] = React.useState({
    breed: '',
    city: '',
    age_from: '',
    age_to: ''
  });
  const [sorting, setSorting] = React.useState({
    sort: 'created_at',
    direction: 'desc'
  });
  const latestPage = useRef(page);
  const latestFilters = useRef(filters);
  const latestSorting = useRef(sorting);

  useEffect(() => {
    axios
      .get(`http://localhost:3001/api/v1/dogs`, {
        headers: {
          Accept: '*/*',
          Authorization: localStorage.getItem('token')
        },
        withCredentials: true
      })
      .then((response) => {
        setDogs(response.data.data);
      })
      .catch((error) => console.log(error));
  }, []);

  function loadDogs() {
    axios
      .get(
        `http://localhost:3001/api/v1/dogs?page=${latestPage.current}&breed=${latestFilters.current.breed}&city=${latestFilters.current.city}&age_from=${latestFilters.current.age_from}&age_to=${latestFilters.current.age_to}&sort=${latestSorting.current.sort}&direction=${latestSorting.current.direction}`,
        {
          headers: {
            Accept: '*/*',
            Authorization: localStorage.getItem('token')
          },
          withCredentials: true
        }
      )
      .then((response) => {
        setDogs(response.data.data);
      })
      .catch((error) => console.log(error));
  }
  const handlePaginations = (event, value) => {
    latestPage.current = value;
    loadDogs();
  };

  function handleFilters(value) {
    latestFilters.current = value;
    loadDogs();
  }

  function handleSorting(value) {
    latestSorting.current.sort != value ||
    latestSorting.current.direction == 'asc'
      ? (latestSorting.current.direction = 'desc')
      : (latestSorting.current.direction = 'asc');
    latestSorting.current.sort = value;
    loadDogs();
  }

  function updateFavoriteState(id) {
    let updatedDogs = dogs.dogs.map((dog) => {
      if (dog.id == id && dog.favorite) {
        dog.favorite = false;
      } else if (dog.id == id && !dog.favorite) {
        dog.favorite = true;
      }
      return dog;
    });
    setDogs({ dogs: updatedDogs, number_of_pages: dogs.number_of_pages });
  }
  return (
    <div>
      <NotificationContainer />
      <Header
        color="transparent"
        routes={dashboardRoutes}
        rightLinks={
          <HeaderLinks
            {...props}
            handleLogout={props.handleLogout}
            loggedInStatus={props.loggedInStatus}
          />
        }
        fixed
        changeColorOnScroll={{
          height: 400,
          color: 'white'
        }}
        {...rest}
      />
      <Parallax small filter image={require('assets/img/dogs-park.jpg')} />
      <div className={classNames(classes.main, classes.mainRaised)}>
        <div className={classes.container}>
          <br />
          <ListOfDogs
            {...props}
            handleSorting={handleSorting}
            handleFilters={handleFilters}
            handlePaginations={handlePaginations}
            updateFavoriteState={updateFavoriteState}
            loggedInStatus={props.loggedInStatus}
            createNotification={props.createNotification}
            dogs={dogs}
            current_user={props.current_user}
            latestPage={latestPage}
            animate={props.animate}
          />
          <br />
        </div>
      </div>
      <Footer />
    </div>
  );
}
