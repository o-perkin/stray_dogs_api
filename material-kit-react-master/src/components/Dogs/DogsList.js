import React, { Component } from 'react';
import axios from 'axios';
import DogCard from 'components/Dogs/DogCard.js';
class DogsList extends Component {

    constructor(props){
      super(props)
    }
    
    render() {
      return (
        <div>
            {this.props.dogs.map(el => { 
              return (
                <div key={el.id}>                
                  <br />
                  <br />
                  <DogCard updateFavoriteState={this.props.updateFavoriteState} current_user={this.props.current_user} loggedInStatus={this.props.loggedInStatus} {...this.props} createNotification={this.props.createNotification} dog={el} /> 
                  <br />   
                </div>           
              )
            })}                                
        </div>
      )
    }
}
export default DogsList;

