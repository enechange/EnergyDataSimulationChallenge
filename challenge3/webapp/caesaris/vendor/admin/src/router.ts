import Vue from 'vue'
import Router from 'vue-router'
import Layout from '@/views/layout/Layout.vue'

Vue.use(Router)

/*
  redirect:                      if `redirect: noredirect`, it won't redirect if click on the breadcrumb
  meta: {
    title: 'title'               the name showed in subMenu and breadcrumb (recommend set)
    icon: 'svg-name'             the icon showed in the sidebar
    breadcrumb: false            if false, the item will be hidden in breadcrumb (default is true)
    hidden: true                 if true, this route will not show in the sidebar (default is false)
  }
*/

export default new Router({
  // mode: 'history',  // Disabled due to Github Pages doesn't support this, enable this if you need.
  scrollBehavior: (to, from, savedPosition) => {
    if (savedPosition) {
      return savedPosition
    } else {
      return { x: 0, y: 0 }
    }
  },
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/login',
      component: () => import(/* webpackChunkName: "login" */ '@/views/login/index.vue'),
      meta: { hidden: true },
    },
    {
      path: '/404',
      component: () => import(/* webpackChunkName: "404" */ '@/views/404.vue'),
      meta: { hidden: true },
    },
    {
      path: '/',
      component: Layout,
      redirect: '/dashboard',
      name: 'Dashboard',
      // meta: { title: 'Dashboard', icon: 'dashboard' },
      meta: { hidden: true },
      children: [{
        path: 'dashboard',
        component: () => import(/* webpackChunkName: "dashboard" */ '@/views/dashboard/index.vue'),
      }],
    },
    {
      path: '/challenges',
      component: Layout,
      redirect: '/challenges/challenge-3', // TODO: change to `challenge-1`
      name: 'Challenges',
      meta: { title: 'Challenges', icon: 'tree' },
      children: [
        {
          path: 'challenge-1',
          name: 'Challenge 1',
          // component: Layout,
          component: () => import(/* webpackChunkName: "challenge-1" */ '@/views/challenges/challenge-1/index.vue'),
          meta: { title: 'Challenge 1', icon: 'example', hidden: true },
        },
        {
          path: 'challenge-2',
          name: 'Challenge 2',
          component: () => import(/* webpackChunkName: "challenge-2" */ '@/views/challenges/challenge-2/index.vue'),
          meta: { title: 'Challenge 2', icon: 'example' },
        },
        {
          path: 'challenge-3',
          name: 'Challenge 3',
          component: () => import(/* webpackChunkName: "challenge-3" */ '@/views/challenges/challenge-3/index.vue'),
          meta: { title: 'Challenge 3', icon: 'example' },
        },
        {
          path: 'challenge-4',
          name: 'Challenge 4',
          component: () => import(/* webpackChunkName: "challenge-4" */ '@/views/challenges/challenge-4/index.vue'),
          meta: { title: 'Challenge 4', icon: 'example', hidden: true },
        },
      ],
    },
    {
      path: '/console',
      component: Layout,
      children: [
        {
          path: 'index',
          name: 'Console',
          component: () => import(/* webpackChunkName: "console" */ '@/views/console/index.vue'),
          meta: { title: 'Console', icon: 'dashboard' },
        },
      ],
    },
    // {
    //   path: '/graphiql',
    //   component: Layout,
    //   children: [
    //     {
    //       path: 'index',
    //       name: 'Graphiql',
    //       component: () => import(/* webpackChunkName: "graphiql" */ '@/views/graphiql/index.vue'),
    //       meta: { title: 'Graphiql', icon: 'graphql' }
    //     }
    //   ]
    // },
    {
      path: 'github-link',
      component: Layout,
      children: [
        {
          path: 'https://github.com/jerrywdlee',
          meta: { title: 'Github', icon: 'github' },
        },
      ],
    },
    {
      path: 'qiita-link',
      component: Layout,
      children: [
        {
          path: 'https://qiita.com/jerrywdlee',
          meta: { title: 'Qiita', icon: 'international' },
        },
      ],
    },
    {
      path: '*',
      redirect: '/404',
      meta: { hidden: true },
    },
  ],
})
