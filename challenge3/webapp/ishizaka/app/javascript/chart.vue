<template>
  <div id="chart">
    <p>{{ message }}</p>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: "チャートを表示します。"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 18px;
  text-align: center;
  color: red;
}
</style>
