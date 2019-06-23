import { mount, createLocalVue } from '@vue/test-utils'
import ElementUI from 'element-ui'
import Hamburger from '@/components/Hamburger/index.vue'
import SvgIcon from 'vue-svgicon'

const localVue = createLocalVue()
localVue.use(ElementUI)
localVue.use(SvgIcon, {
  tagName: 'svg-icon',
  defaultWidth: '1em',
  defaultHeight: '1em'
})

describe('Hamburger.vue', () => {
  const wrapper = mount(Hamburger, {
    localVue,
    propsData: { toggleClick: () => null },
  })

  it('GithubCorner should hide', () => {
    const githubCorner = wrapper.findAll('.hamburger-container')
    expect(githubCorner.length).toBe(1)
  })
})
