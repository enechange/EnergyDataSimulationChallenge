<template>
  <div>
    <div class="card">
      <div class="card-header">
        <div class="card-header-title subtitle">Which area do you live in ?</div>
      </div>
      <div class="card-content">
        <form @change.prevent="exec">
          <div v-for="cityName in cityList" :key="cityName">
            <input type="radio" :id="cityName" :value="cityName" v-model="params['q']['city']">
            <label for="cityName">{{ cityName }}</label>
            <br>
          </div>
        </form>
      </div>
    </div>
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