import React, { Component } from 'react';

import {
  ResponsiveContainer, LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend,
} from 'recharts';
import axiosbase from 'axios';
import moment from 'moment';

const axios = axiosbase.create({
  baseURL: window.location.protocol + '//' + window.location.hostname + ':3000',
  headers: {
    'Content-Type': 'application/json',
  },
  responseType: 'json',
})


class Home extends Component {
  constructor(props){
    super(props)
    this.state = {
      data: [],
      lists: [],
    };
  }
  
  componentDidMount() {
    axios
    .get('/')
    .then((res) => {
      let datas = [];
      res.data.data.map((data) => {
        datas.push({date: data.date, Cambridge: data.cambridge, London: data.london, Oxford: data.oxford})
      })
      this.setState({data: datas});
    })
    .catch((err) => {
      console.log(err) // 失敗
    });
  }

  render () {
    const data = this.state.data;

    return (
      <div>
      <LineChart
        width={980}
        height={300}
        data={data}
        margin={{
          top: 5, right: 30, left: 20, bottom: 5,
        }}
      >
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="date" />
        <YAxis />
        <Tooltip />
        <Legend />
        <Line type="monotone" dataKey="Cambridge" stroke="#00fa9a" activeDot={{ r: 8 }} />
        <Line type="monotone" dataKey="London" stroke="#8884d8" activeDot={{ r: 8 }} />
        <Line type="monotone" dataKey="Oxford" stroke="#ff69b4" activeDot={{ r: 8 }} />
      </LineChart>
      </div>
    );
  }
}

export default Home;