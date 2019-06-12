<template>
  <div id="app">
    <p>{{ message }}</p>
  </div>
</template>

<script>
console.log('hello')

export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
