import Vue from 'vue/dist/vue.esm'
import VHome from '../components/VHome'

document.addEventListener('DOMContentLoaded', () => {

  new Vue({
    el: '#app',
    data: {
      record: null,
    },
    components: { VHome },
    template: '<v-home></v-home>'
  })

})
