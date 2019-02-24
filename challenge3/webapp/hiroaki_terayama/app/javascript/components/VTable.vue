<template>
  <div>
    <table class="table">
      <thead>
        <tr>
          <th>which area</th>
          <th v-for="month in labels" :key="month">{{ month }}</th>
          <th>Average</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>all area</td>
          <td v-for="data in allData">{{ data }}</td>
          <td>{{ aveAll }}</td>
        </tr>
        <tr>
          <td>your area</td>
          <td v-for="data in selectedData">{{ data }}</td>
          <td>{{ aveSelected }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
  export default {
    props: ['allData', 'selectedData', 'aveAll', 'aveSelected'],
    data () {
      return {
        labels: [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ],
      }
    },
    methods: {

    }
  }
</script>