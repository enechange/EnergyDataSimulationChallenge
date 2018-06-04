import axios from 'axios';

const GET_ENERGY_URL = '/apis/energy';
const GET_AVERAGE_URL = '/apis/average';

export default {
  getEnergyData: function (userId, year) {
    return axios.get(`${GET_ENERGY_URL}/${userId}/${year}`)
  },
  getAverage: function () {
    return axios.get(GET_AVERAGE_URL)
  }
};
