import * as React from 'react';
import axios from 'axios';
import {
  BarChart, Bar, Cell, XAxis, YAxis, CartesianGrid, Tooltip, Legend,
} from 'recharts';

interface ReportProps {
  name: string;
  endPoint: string;
  dataKey: string
}
const Report: React.FunctionComponent<ReportProps> = ({ name, endPoint, dataKey }) => {
  const [chartData, setChartData] = React.useState([]);

  const loadData = (endPoint: string) => {
    axios.get<[]>(endPoint)
      .then( res => {
        setChartData(res.data)
      });
  }

  React.useEffect(() => {
    loadData(endPoint);
  }, [endPoint]);

  return (
    <BarChart
      width={1000}
      height={1000}
      data={chartData}
      margin={{
        top: 10, right: 30, left: 0, bottom: 0,
      }}
    >
      <CartesianGrid strokeDasharray="9 9" />
      <XAxis dataKey="name" />
      <YAxis />
      <Tooltip />
      <Bar stackId="a" dataKey={dataKey} fill="#8884d8" />
    </BarChart>
  );
}

export default Report;
