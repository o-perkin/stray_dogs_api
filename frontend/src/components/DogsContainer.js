import React, { Component } from 'react';
import axios from 'axios';
class DogsContainer extends Component {
    constructor(props){
        super(props)
        this.state = {
            dogs: []
        }
    }
    componentDidMount() {
        axios.get('http://localhost:3001/api/v1/dogs.json')
        .then(response => {
            console.log(response)
            this.setState({
                dogs: response.data
            })
        })
        .catch(error => console.log(error))
    }
    render() {
        return (
            <div className="Dogs-container">
                Dogs
            </div>
        )
    }
}
export default DogsContainer;