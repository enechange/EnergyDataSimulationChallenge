<template lang="pug">
  #app
    router-view
</template>

<script lang="ts">
import { Vue, Component } from 'vue-property-decorator'

@Component
export default class App extends Vue {}
</script>
