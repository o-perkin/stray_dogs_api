import React, { Component } from 'react';
import axios from 'axios';
import DogCard from 'components/Dogs/DogCard.js';
class FavoritesList extends Component {
    constructor(props){
      super(props) 
      this.state = {
          dogs: []
      }

      this.updateFavoriteState = this.updateFavoriteState.bind(this);
    }
    componentDidMount() {
      axios.get('http://localhost:3001/api/v1/favorite_dogs.json', {
        headers: {'Accept': '*/*', 'Authorization': localStorage.getItem('token')},
        withCredentials: true
    })
      .then(response => {
          this.setState({
            dogs: response.data.data
          })  
      })
      .catch(error => console.log(error))
    }

    updateFavoriteState(id) {
      this.setState({
        dogs: this.state.dogs.filter(dog => dog.id != id)
      })
    }
    render() {
      return (
        <div>
            {this.state.dogs.map(el => { 
              return (
                <div key={el ? el.id : null}>                
                  <br />
                  <br />
                  <DogCard updateFavoriteState={this.updateFavoriteState} current_user={this.props.current_user} loggedInStatus={this.props.loggedInStatus} {...this.props} createNotification={this.props.createNotification} dog={el} /> 
                  <br />   
                </div>           
              )
            })}                                
        </div>
      )
    }
}
export default FavoritesList;

