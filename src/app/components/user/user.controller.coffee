angular.module "door"
  .controller "UserController", ($rootScope, $scope, userService, $state) ->

    # $('#login-body').ripples({
    #   resolution: 512,
    #   dropRadius: 20, #px
    #   perturbance: 0.04
    # })
    $scope.slides = [
      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },
      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },
      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },

      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },

      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },

      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },

      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },
      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },
      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },

      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },

      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },

      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },

      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },

      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },

      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      },

      {
        image: '/assets/images/identity1.png',
        text: 'xxxxx'
      }
    ]
    $scope.user = {}

    $scope.login = ->
      promise = userService.login($scope.user.login, $scope.user.password)
      promise.then ( (result) ->
          userService.user = result.user
          $state.go('profile')
        ), (result) ->
        console.log '登录错误'
        

    $scope.registe = ->



    return
