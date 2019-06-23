<template lang="pug">
  .wscn-http404-container
    .wscn-http404
      .pic-404
        img.pic-404__parent(src='@/assets/404_images/404.png', alt='404')
        img.pic-404__child.left(src='@/assets/404_images/404_cloud.png', alt='404')
        img.pic-404__child.mid(src='@/assets/404_images/404_cloud.png', alt='404')
        img.pic-404__child.right(src='@/assets/404_images/404_cloud.png', alt='404')
      .text-404
        .text-404__oops
          | OOPS!
        .text-404__info
          | Copyright (c) 2019
          a.link-type(href='https://github.com/jerrywdlee/EnergyDataSimulationChallenge', target='_blank')
            |  Iuliana Caesaris Augusta
        .text-404__headline
          | {{ message }}
        .text-404__info
          | The URL requested was not found on this server. <br>
          | Please back to top and try again.
        a.text-404__return-home(href='/') Back To Top
</template>

<script lang='ts'>
import { Component, Vue } from 'vue-property-decorator'

@Component
export default class NotFound extends Vue {
  get message() {
    return '404 Page Not Found.'
  }
}
</script>

<style lang="scss" scoped>
.wscn-http404-container{
  transform: translate(-50%,-50%);
  position: absolute;
  top: 40%;
  left: 50%;
}

.wscn-http404 {
  position: relative;
  width: 1200px;
  padding: 0 50px;
  overflow: hidden;

  .pic-404 {
    position: relative;
    float: left;
    width: 600px;
    overflow: hidden;

    &__parent {
      width: 100%;
    }

    &__child {
      position: absolute;

      &.left {
        width: 80px;
        top: 17px;
        left: 220px;
        opacity: 0;
        animation-name: cloudLeft;
        animation-duration: 2s;
        animation-timing-function: linear;
        animation-fill-mode: forwards;
        animation-delay: 1s;
      }

      &.mid {
        width: 46px;
        top: 10px;
        left: 420px;
        opacity: 0;
        animation-name: cloudMid;
        animation-duration: 2s;
        animation-timing-function: linear;
        animation-fill-mode: forwards;
        animation-delay: 1.2s;
      }

      &.right {
        width: 62px;
        top: 100px;
        left: 500px;
        opacity: 0;
        animation-name: cloudRight;
        animation-duration: 2s;
        animation-timing-function: linear;
        animation-fill-mode: forwards;
        animation-delay: 1s;
      }

      @keyframes cloudLeft {
        0% {
          top: 17px;
          left: 220px;
          opacity: 0;
        }

        20% {
          top: 33px;
          left: 188px;
          opacity: 1;
        }

        80% {
          top: 81px;
          left: 92px;
          opacity: 1;
        }

        100% {
          top: 97px;
          left: 60px;
          opacity: 0;
        }
      }

      @keyframes cloudMid {
        0% {
          top: 10px;
          left: 420px;
          opacity: 0;
        }

        20% {
          top: 40px;
          left: 360px;
          opacity: 1;
        }

        70% {
          top: 130px;
          left: 180px;
          opacity: 1;
        }

        100% {
          top: 160px;
          left: 120px;
          opacity: 0;
        }
      }

      @keyframes cloudRight {
        0% {
          top: 100px;
          left: 500px;
          opacity: 0;
        }

        20% {
          top: 120px;
          left: 460px;
          opacity: 1;
        }

        80% {
          top: 180px;
          left: 340px;
          opacity: 1;
        }

        100% {
          top: 200px;
          left: 300px;
          opacity: 0;
        }
      }
    }
  }

  .text-404 {
    position: relative;
    float: left;
    width: 300px;
    padding: 30px 0;
    overflow: hidden;

    &__oops {
      font-size: 32px;
      font-weight: bold;
      line-height: 40px;
      color: #1482f0;
      opacity: 0;
      margin-bottom: 20px;
      animation-name: slideUp;
      animation-duration: 0.5s;
      animation-fill-mode: forwards;
    }

    &__headline {
      font-size: 20px;
      line-height: 24px;
      color: #222;
      font-weight: bold;
      opacity: 0;
      margin-bottom: 10px;
      animation-name: slideUp;
      animation-duration: 0.5s;
      animation-delay: 0.1s;
      animation-fill-mode: forwards;
    }

    &__info {
      font-size: 13px;
      line-height: 21px;
      color: grey;
      opacity: 0;
      margin-bottom: 30px;
      animation-name: slideUp;
      animation-duration: 0.5s;
      animation-delay: 0.2s;
      animation-fill-mode: forwards;
    }

    &__return-home {
      display: block;
      float: left;
      width: 110px;
      height: 36px;
      background: #1482f0;
      border-radius: 100px;
      text-align: center;
      color: #ffffff;
      opacity: 0;
      font-size: 14px;
      line-height: 36px;
      cursor: pointer;
      animation-name: slideUp;
      animation-duration: 0.5s;
      animation-delay: 0.3s;
      animation-fill-mode: forwards;
    }

    @keyframes slideUp {
      0% {
        transform: translateY(60px);
        opacity: 0;
      }

      100% {
        transform: translateY(0);
        opacity: 1;
      }
    }
  }
}

@media (max-width: 1199px) {
  .wscn-http404 {
    width: 1000px;
  }
}

@media (max-width: 975px) {
  .wscn-http404 {
    display: flex;
    width: 100vw;
    padding-left: 0;
    padding-right: 0;
  }
}

@media (max-width: 800px) {
  .wscn-http404 {
    justify-content: center;
    flex-direction: column;
    .pic-404 {
      float: none;
      margin-left: 50px;
      margin-top: 60px;
      .pic-404__parent {
        width: calc(100vw - 20px);
      }
    }
    .text-404 {
      float: none;
      display: block;
      width: calc(100vw - 20px);
      padding-left: 10%;
    }
  }
}

</style>
