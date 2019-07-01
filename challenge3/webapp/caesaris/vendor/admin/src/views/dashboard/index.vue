<template lang="pug">
  .dashboard-container
    github-corner(
      size=65,
      url="https://github.com/jerrywdlee/EnergyDataSimulationChallenge/tree/challenge3/iuliana_caesaris/challenge3/webapp/caesaris"
    )
    h1.dashboard-text Energy Data Simulation Challenges
    //.dashboard-text
      span(v-for="role in roles", :key="role") {{ role }}
    card-group(:card-infos="cardInfos")
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import { UserModule } from '@/store/modules/user'
import CardGroup from './components/CardGroup.vue'
import GithubCorner from '@/components/GithubCorner/index.vue'

const cardInfos = [
  {
    title: 'Challenge 1',
    text: 'Energy Production Data Simulation',
    target: '',
    imgUrl: 'https://picsum.photos/id/830/400/300'
  },
  {
    title: 'Challenge 2',
    text: 'Visualization of Energy Consumptions',
    target: '/challenges/challenge-2',
    imgUrl: 'https://picsum.photos/id/603/400/300'
  },
  { title: 'Challenge 3',
    text: 'Web Application',
    target: '/challenges/challenge-3',
    imgUrl: 'https://picsum.photos/id/18/400/300'
  },
  {
    title: 'Challenge 4',
    text: 'WEB-API Server',
    target: '',
    imgUrl: 'https://picsum.photos/id/909/400/300'
  }
]

@Component({
  components: { CardGroup, GithubCorner }
})
export default class Dashboard extends Vue {
  get name() {
    return UserModule.name
  }

  get roles() {
    return UserModule.roles
  }

  get cardInfos() {
    return cardInfos
  }
}
</script>

<style lang="scss" scoped>
.dashboard {
  &-container {
    // margin: 30px;
    padding: 32px;
    background-color: rgb(240, 242, 245);
    position: relative;
    min-height: calc(100vh - 50px);
    h1 {
      margin-top: 0;
      color: #303133;
    }
  }

  &-text {
    font-size: 30px;
    line-height: 46px;
  }
}

.github-corner {
  position: absolute;
  top: 0;
  border: 0;
  right: 0;
}
</style>
