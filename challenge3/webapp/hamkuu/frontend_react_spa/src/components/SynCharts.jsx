import React, { PureComponent } from 'react';
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  AreaChart,
  Area,
  BarChart,
  Bar,
  Legend,
} from 'recharts';

export default class SynCharts extends PureComponent {
  render() {
    const records = this.props.records;

    return (
      <div>
        <h4>Temperature and Daylight</h4>
        <BarChart
          width={1700}
          height={200}
          data={records}
          syncId='anyId'
          margin={{
            top: 10,
            right: 0,
            left: 0,
            bottom: 0,
          }}
        >
          <CartesianGrid strokeDasharray='3 3' />
          <XAxis dataKey='recordDate' />
          <YAxis yAxisId='left' orientation='left' stroke='#8884d8' />
          <YAxis yAxisId='right' orientation='right' stroke='#82ca9d' />
          <Tooltip />
          <Legend />
          <Bar yAxisId='left' dataKey='temperature' fill='#8884d8' />
          <Bar yAxisId='right' dataKey='daylight' fill='#82ca9d' />
        </BarChart>

        <h4>EnergyProduction</h4>
        <AreaChart
          width={1650}
          height={200}
          data={records}
          syncId='anyId'
          margin={{
            top: 10,
            right: 0,
            left: 0,
            bottom: 0,
          }}
        >
          <CartesianGrid strokeDasharray='3 3' />
          <XAxis dataKey='recordDate' />
          <YAxis />
          <Tooltip />
          <Area
            type='monotone'
            dataKey='energyProduction'
            stroke='#82ca9d'
            fill='#82ca9d'
          />
        </AreaChart>
      </div>
    );
  }
}
