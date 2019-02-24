<template>
  <form @change.prevent="exec">
    <div v-for="cityName in cityList" :key="cityName">
      <input type="radio" :id="cityName" :value="cityName" v-model="params['q']['city']">
      <label for="cityName">{{ cityName }}</label>
      <br>
    </div>
    <input type="number" v-model="params['q']['num_of_people']"/>
    <br>
    <input type="radio" id="Yes" value="Yes" v-model="params['q']['has_child']">
    <label for="Yes">Yes</label>
    <br>
    <input type="radio" id="No" value="No" v-model="params['q']['has_child']">
    <label for="No">No</label>
    <br>
  </form>
</template>

<script>
  export default {
    data () {
      return {
        cityList: ['London', 'Cambridge', 'Oxford'],
        params: {
          q: {
            city: '',
            num_of_people: 2,
            has_child: '',
          }
        }
      }
    },
    methods: {
      exec () {
        this.$emit('search', this.params)
      }
    }
  }
</script>