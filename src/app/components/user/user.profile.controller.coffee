angular.module "door"
  .controller "UserController", ($rootScope, $scope, userService, $state) ->

    $scope.user = {}

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

    return
