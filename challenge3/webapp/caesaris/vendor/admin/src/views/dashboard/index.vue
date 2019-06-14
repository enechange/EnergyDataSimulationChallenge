<template>
  <div class="dashboard-container">
    <div class="dashboard-text">
      name:{{ name }}
    </div>
    <div class="dashboard-text">
      roles:<span
        v-for="role in roles"
        :key="role"
      >{{ role }}</span>
    </div>
    <card-group :card-infos="cardInfos" />
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import { UserModule } from '@/store/modules/user'
import CardGroup from './components/CardGroup.vue'

const cardInfos = [
  { title: 'Challenge 1', target: '/form/index' },
  { title: 'Challenge 2', target: '/nested/menu2' },
  { title: 'Challenge 3', target: '' },
  { title: 'Challenge 4', target: '' }
]

@Component({
  components: { CardGroup }
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
  }

  &-text {
    font-size: 30px;
    line-height: 46px;
  }
}
</style>
