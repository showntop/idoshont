angular.module "door"
  .controller "UserController", ($rootScope, $scope, userService, $state) ->

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
