import React, { Component } from 'react';
import axios from 'axios';
import { makeStyles } from '@material-ui/core/styles';
import { LoopCircleLoading } from 'react-loadingg';
import clsx from 'clsx';
import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import CardMedia from '@material-ui/core/CardMedia';
import CardContent from '@material-ui/core/CardContent';
import CardActions from '@material-ui/core/CardActions';
import Collapse from '@material-ui/core/Collapse';
import Avatar from '@material-ui/core/Avatar';
import IconButton from '@material-ui/core/IconButton';
import Typography from '@material-ui/core/Typography';
import { red } from '@material-ui/core/colors';
import FavoriteIcon from '@material-ui/icons/Favorite';
import ShareIcon from '@material-ui/icons/Share';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';
import MoreVertIcon from '@material-ui/icons/MoreVert';
import DeleteIcon from '@material-ui/icons/Delete';
import Button from '@material-ui/core/Button';
import EditIcon from '@material-ui/icons/Edit';

class DogMainCard extends Component { 
  
  constructor(props){
    super(props)
    this.state = {
        dog: {},
        animate: false
    }

    this.deleteDog = this.deleteDog.bind(this);
    this.favoriteUpdate = this.favoriteUpdate.bind(this);
    this.updateFavoriteState = this.updateFavoriteState.bind(this);
  }
  componentDidMount() {
    axios.get(`http://localhost:3001/api/v1/dogs/${this.props.match.params.dogId}.json`, 
    {
      headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
      withCredentials: true
    })
    .then(response => {
        this.setState({
          dog: response.data.data.dog[0],
          user: response.data.data.dog[0].user
        })
        console.log('pomidor', this.state.dog[0])
    })
    .catch(error => {
      if (error.response.status === 401) {
        this.setState({
          errors: "Access denied",
        })
      } else if (error.response.status === 404) {
        this.setState({
          dog: null
        })
        console.log('QWEEWQQWE', this.state.dog);
      }
      
      console.log(error)
    })
  }

  deleteDog() {
    this.setState({
      animate: true,
    })
    axios.delete(`http://localhost:3000/api/v1/dogs/${this.props.match.params.dogId}`, 
    {
      headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
      withCredentials: true
    }).then(response => {
      if(response.status === 200) {
        this.props.history.push('/my_list');
      }
      console.log("response", response);
      this.setState({
        animate: false,
      })
    }).catch(error => {
      this.props.createNotification('error', 'Error', 'Access denied')
      console.log("delete dog errors", error);
      this.setState({
        animate: false,
      })
    })
  }

  favoriteUpdate(event) {
    axios.get(`http://localhost:3000/api/v1/favorites/update?dog=${this.props.match.params.dogId}`, 
    {
      headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
      withCredentials: true
    }).then(response => {        
      if(response.status === 200) {
        this.updateFavoriteState(this.props.match.params.dogId);
      }
      console.log("BYABYA", this.state.user)
    }).catch(error => {
      console.log("delete dog errors", error);
    })
  }

  updateFavoriteState(id) {
    let asd = this.state.dog
        asd.favorite == true ? asd.favorite = false : asd.favorite = true 
    this.setState({
        dog: asd
    })
  }
  
  render() {
    if (this.state.dog == null) {
      this.props.history.push('/dogs');
      return <div></div> 
    } else {

      return (
        <Card className={this.props.classes.root} >
          <CardMedia
            className={this.props.classes.media}
            image={require("assets/img/dog.jpg")}
            title="Paella dish"
          />
          <CardContent>          
            <h2>{this.state.dog.name}</h2>       
            <Typography variant="body2" color="textSecondary" component="div">            
              <p>Порода: {this.state.dog.breed}</p>
              <p>Місто: {this.state.dog.city}</p>
              <p>Вік: {this.state.dog.age} років</p>
              <p>
                Власник: {this.state.user ? this.state.user.first_name : null}{" "}             
                {this.state.user ? this.state.user.last_name : null}
              </p>
              <p>Дата публікації: {this.state.dog.created_at}</p>
            </Typography>
            <Typography color="textPrimary" paragraph>{this.state.dog.description}</Typography>
          </CardContent>
          <CardActions disableSpacing>
            {this.props.loggedInStatus == 'LOGGED_IN'
              ? <IconButton onClick={this.favoriteUpdate} aria-label="add to favorites">
                  <FavoriteIcon color={this.state.dog.favorite ? 'secondary' : 'disabled' } />
                </IconButton>
              : null}
            {this.state.user ? 
              this.state.user.id == this.props.current_user.id && this.props.loggedInStatus == "LOGGED_IN" 
                ? <>
                    <Button
                      variant="contained"
                      style={{marginLeft: 'auto', backgroundColor: 'yellow'}}
                      href={`/dogs/edit/${this.props.match.params.dogId}`}
                      className={this.props.classes.button}
                      startIcon={<EditIcon />}
                    >
                      Редагувати
                    </Button>
                    <Button
                      variant="contained"
                      color="secondary"
                      className={this.props.classes.button}
                      startIcon={<DeleteIcon />}
                      onClick={this.deleteDog}
                      disabled={this.state.animate ? true : false}
                    >
                      Видалити
                    </Button>
                  </>
                : null : null}          
            <LoopCircleLoading color='purple' style={this.state.animate ? {} : {display: "none"}} />
          </CardActions>
        </Card>
      );
    }
  }
  
}

export default DogMainCard;

