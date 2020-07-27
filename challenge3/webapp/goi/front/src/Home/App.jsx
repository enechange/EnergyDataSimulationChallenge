import React, { Component } from 'react';

import {
  ResponsiveContainer, LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend,
} from 'recharts';
import axiosbase from 'axios';
import moment from 'moment';


const axios = axiosbase.create({
  baseURL: `${process.env.REACT_APP_SERVER_URL}`,
  headers: {
    'Content-Type': 'application/json',
  },
  responseType: 'json',
})


class Home extends Component {
  constructor(props){
    super(props)
    console.log(`${process.env.REACT_APP_SERVER_URL}`);
    this.state = {
      data: [],
      lists: [],
    };
  }
  
  componentDidMount() {
    axios
    .get('/api/v1/dashboard')
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
