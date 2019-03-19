import { Chart, ChartData, ChartOptions } from 'chart.js';
declare var gon: any;

const data = {
  labels: gon.year_month,
  datasets: [
    {
      label: 'Energy Production',
      lineTension: 0, fill: false,
      borderColor: 'rgb(255, 0, 0)',
      data: gon.energy_production,
    },
    {
      label: 'Daylight',
      lineTension: 0, fill: false,
      borderColor: 'rgb(0, 255, 0)',
      data: gon.daylight,
    },
  ],
};

const options = {
  scales: {
    yAxes: [
      { type: 'linear', position: 'left', ticks: { beginAtZero:true } },
      { type: 'linear', position: 'right', ticks: { beginAtZero:true } },
    ],
  }      };
}

function graph_init() {
  const elm: HTMLCanvasElement = <HTMLCanvasElement>document.getElementById('HouseChart');

  if (elm == null) {
    throw new Error('No Canvas');
  }

  const graph = new Chart(elm.getContext('2d'), { data, options, type: 'line' });
}

window.addEventListener('DOMContentLoaded', graph_init);
