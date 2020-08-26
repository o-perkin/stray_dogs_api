import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
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
import EditIcon from '@material-ui/icons/Edit';
import VisibilityIcon from '@material-ui/icons/Visibility';
import axios from 'axios';

const useStyles = makeStyles((theme) => ({
  root: {
    maxWidth: 500,
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
}));

export default function DogCard(props) {

  const classes = useStyles();
  const [expanded, setExpanded] = React.useState(false);

  const handleExpandClick = () => {
    setExpanded(!expanded);
  };

  const deleteDog = (event) => {
    axios.delete(`http://localhost:3000/api/v1/dogs/${props.dog.id}`, 
    {
      headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
      withCredentials: true
    }).then(response => {
      if(response.status === 200) {
        props.history.go(0);
      }
      console.log("response", response);
    }).catch(error => {
      props.createNotification('error', 'Error', 'Access denied')
      console.log("delete dog errors", error);
    })
  }

  const favoriteUpdate = (event) => {
    axios.get(`http://localhost:3000/api/v1/favorites/update?dog=${props.dog.id}`, 
    {
      headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
      withCredentials: true
    }).then(response => {        
      if(response.status === 200) {
        props.updateFavoriteState(props.dog.id);
      }
    }).catch(error => {
      console.log("delete dog errors", error);
    })
  }

  return (
    <Card className={classes.root}>
      <CardHeader
        avatar={
          <Avatar aria-label="recipe" className={classes.avatar}>
            R
          </Avatar>
        }
        title={"Author " + props.dog.user.first_name + " " + props.dog.user.last_name}
        subheader={props.dog.created_at}
      />
      <CardMedia
        className={classes.media}
        image={require("assets/img/dog.jpg")}
        title="Paella dish"
      />
      <CardContent>
        <Typography variant="body2" color="textSecondary" component="p">
          <div key={props.dog.id}>
            <p>Dog {props.dog.name}</p>
            <p>Breed {props.dog.breed}</p>
            <p>City {props.dog.city}</p>
            <p>Age {props.dog.age}</p>
          </div>
        </Typography>
      </CardContent>
      <CardActions disableSpacing>
      {props.loggedInStatus == "LOGGED_IN" ?
        <IconButton onClick={favoriteUpdate} aria-label="add to favorites">
          <FavoriteIcon color={props.dog.favorite ? 'secondary' : 'disabled' } />
        </IconButton>
        : null
      }
        <IconButton href={`/dogs/${props.dog.id}`} style={{marginLeft: 'auto'}} color="primary" aria-label="add to favorites">
          <VisibilityIcon />
        </IconButton>
        {props.current_user.roles == 'site_admin' && props.loggedInStatus == "LOGGED_IN" ? <div> 
          <IconButton href={`/dogs/edit/${props.dog.id}`} style={{color: '#CAB40E'}} aria-label="edit">
          <EditIcon />
          </IconButton>
          <IconButton onClick={deleteDog} style={{color: 'red'}} aria-label="delete">
            <DeleteIcon />
          </IconButton>
          </div>
          : null 
        }
        <IconButton
        style={{marginLeft: 0 + 'px'}}
          className={clsx(classes.expand, {
            [classes.expandOpen]: expanded,
          })}
          onClick={handleExpandClick}
          aria-expanded={expanded}
          aria-label="show more"
        >
          <ExpandMoreIcon />
        </IconButton>
      </CardActions>
      <Collapse in={expanded} timeout="auto" unmountOnExit>
        <CardContent>
          <Typography paragraph>Опис:</Typography>
          <Typography paragraph>
            {props.dog.description}
          </Typography>
        </CardContent>
      </Collapse>
    </Card>
  );
}
