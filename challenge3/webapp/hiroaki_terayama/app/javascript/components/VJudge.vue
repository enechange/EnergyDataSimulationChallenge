<template>
  <div class="card">
    <div class="card-header">
      <div class="card-header-title">Judge result</div>
    </div>
    <div class="card-content">
      <div v-if="aveSelected">You will get <span class="is-size-1" v-bind:class="{ 'has-text-danger': isMore, 'has-text-primary': !isMore }">{{ judge }}</span> energy than average !</div>
      <div v-else>Not judged yet !</div>
    </div>
  </div>
</template>

<script>
  export default {
    props: ['aveAll', 'aveSelected'],
    data () {
      return {
        isMore: false,
      }
    },
    watch: {
      aveSelected () {
        this.isMore = this.aveAll < this.aveSelected
      }
    },
    computed: {
      judge () {
        return this.isMore ? 'more' : 'less'
      }
    }
  }
</script>