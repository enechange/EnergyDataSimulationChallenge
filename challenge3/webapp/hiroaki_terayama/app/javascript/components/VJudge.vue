<template>
  <div class="card">
    <div class="card-header">
      <div class="card-header-title">Judge</div>
    </div>
    <div class="card-content">
      <div v-if="isJudged">You will get <span class="is-size-1" v-bind:class="{ 'has-text-danger': isMore, 'has-text-primary': !isMore }">{{ judge() }}</span> energy than average !</div>
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
        isJudged: false,
      }
    },
    watch: {
      aveSelected () {
        this.isJudged = true
      }
    },
    methods: {
      judge () {
        if (this.aveAll < this.aveSelected) {
          this.isMore = true
          return 'more'
        } else {
          this.isMore = false
          return 'less'
        }
      },
    }
  }
</script>