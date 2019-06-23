import { mount, createLocalVue } from '@vue/test-utils'
import ElementUI from 'element-ui'
import GithubCorner from '@/components/GithubCorner/index.vue'

const localVue = createLocalVue()
localVue.use(ElementUI)

describe('GithubCorner.vue', () => {

  it('GithubCorner should shown', () => {
    const wrapper = mount(GithubCorner, {
      localVue,
      propsData: { url: 'https://example.com' },
    })
    const githubCorner = wrapper.find('.github-corner')
    expect(githubCorner).toBeTruthy()
  })

  it('GithubCorner should hide', () => {
    const wrapper = mount(GithubCorner, {
      localVue,
      propsData: { url: '' },
    })
    const githubCorner = wrapper.findAll('.github-corner')
    expect(githubCorner.length).toBe(0)
  })
})
