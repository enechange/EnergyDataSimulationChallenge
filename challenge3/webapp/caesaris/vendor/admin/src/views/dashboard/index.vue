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
    <card-group />
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import { UserModule } from '@/store/modules/user'
import CardGroup from './components/CardGroup.vue'

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
