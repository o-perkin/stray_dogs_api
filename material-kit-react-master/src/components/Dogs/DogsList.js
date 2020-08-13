import React, { Component } from 'react';
import axios from 'axios';
import DogCard from 'components/Dogs/DogCard.js';
class DogsList extends Component {
    constructor(props){
      super(props)
      this.state = {
          dogs: []
      }
    }
    componentDidMount() {
      axios.get('http://localhost:3001/api/v1/dogs.json')
      .then(response => {
          this.setState({
              dogs: response.data.data
          })
      })
      .catch(error => console.log(error))
    }
    render() {
      return (
        <div>
            {this.state.dogs.map(el => { 
            console.log(el)            
              return (
                <div>
                  <br />
                  <br />
                  <DogCard dog={el} /> 
                  <br />   
                </div>           
              )
            })}                                
        </div>
      )
    }
}
export default DogsList;

