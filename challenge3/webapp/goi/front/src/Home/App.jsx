import React, { Component } from 'react';

import {
  LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend,
} from 'recharts';
import axiosbase from 'axios';

const axios = axiosbase.create({
  baseURL: 'http://localhost:3000',
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
      // year: [],
      // month: [],
      // energy_production: [],
    };
  }
  
  componentDidMount() {
    axios
    .get('/')
    .then((res) => {
      console.log(res.data);
      this.setState({ data: res.data });
      // console.dir(res.data.data.energy_production[0]);
    })
    .catch((err) => {
      console.log(err) // 失敗
    });
  }

  render () {
    //// - Memo -
    //// 1. レスポンスは返ってきている
    //// 2. 一応画面描画もできている
    //// 3. API設計し直した方が早いかも...
    //// this.state.dataを取得してエレメント作らないといけない
    //// 難しいので取得レスポンスの形を考え直した方が早いかも
    //// res.data.dataでレスポンス内容を取得可能
    //// - 2020/07/12 -

    // const data = [
    //   {
    //     Oxford: this.state.data.data.energy_production
    //   },
    //   {
    //     Oxford: this.state.data.data.energy_production
    //   },
    //   {
    //     Oxford: this.state.data.data.energy_production
    //   }
    // ];

    const data = [
      {
        name: 'Page A', uv: 4000, pv: 2400, amt: 2400,
      },
      {
        name: 'Page B', uv: 3000, pv: 1398, amt: 2210,
      },
      {
        name: 'Page C', uv: 2000, pv: 9800, amt: 2290,
      },
      {
        name: 'Page D', uv: 2780, pv: 3908, amt: 2000,
      },
      {
        name: 'Page E', uv: 1890, pv: 4800, amt: 2181,
      },
      {
        name: 'Page F', uv: 2390, pv: 3800, amt: 2500,
      },
      {
        name: 'Page G', uv: 3490, pv: 4300, amt: 2100,
      },
    ];

    return (
      <div>
      <LineChart
        width={500}
        height={300}
        data={data}
        margin={{
          top: 5, right: 30, left: 20, bottom: 5,
        }}
      >
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="name" />
        <YAxis />
        <Tooltip />
        <Legend />
        {/* <Line type="monotone" dataKey="pv" stroke="#8884d8" activeDot={{ r: 8 }} />
        <Line type="monotone" dataKey="uv" stroke="#82ca9d" /> */}
        <Line type="monotone" dataKey="uv" stroke="#8884d8" activeDot={{ r: 8 }} />
        <Line type="monotone" dataKey="pv" stroke="#82ca9d" />
        {/* <Line type="monotone" dataKey="London" stroke="#82ca9d" /> */}
      </LineChart>
      </div>
    );
  }
}

export default Home;