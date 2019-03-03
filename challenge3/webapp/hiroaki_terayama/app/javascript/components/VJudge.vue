<template>
  <div class="card">
    <div class="card-header">
      <div class="card-header-title">Judge result</div>
    </div>
    <div class="card-content">
      <div v-if="aveSelected">You will get <span class="is-size-1" v-bind:class="{ 'has-text-danger': isMore, 'has-text-primary': !isMore }">{{ getJudge }}</span> energy than average !</div>
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
        if (this.aveAll < this.aveSelected) {
          this.isMore = true
        } else {
          this.isMore = false
        }
      }
    },
    computed: {
      getJudge () {
        if (this.isMore) {
          return 'more'
        } else {
          return 'less'
        }
      }
    }
  }
</script>