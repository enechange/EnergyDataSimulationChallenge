<template>
  <div>
    <div class="subtitle">Which area do you live in ?</div>
    <form @change.prevent="exec">
      <div v-for="cityName in cityList" :key="cityName">
        <input type="radio" :id="cityName" :value="cityName" v-model="params['q']['city']">
        <label for="cityName">{{ cityName }}</label>
        <br>
      </div>
    </form>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        cityList: ['London', 'Cambridge', 'Oxford'],
        params: {
          q: {
            city: '',
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