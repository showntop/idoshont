angular.module "door"
  .controller "UserAuthCtrl", ($scope, userService, $state, toastr) ->

    $scope.errors = []

    $scope.user = {}

    $scope.login = (credentials) ->
      promise = userService.login(credentials)
      promise.then ( (result) ->
          $scope.setCurrentUser(result.user)
        ), (result) ->
        console.log '登录错误'
        
    $scope.registe = (user) ->
      promise = userService.registe(user)
      promise.then ( (result) ->
        $scope.setCurrentUser(result.user)
        $state.go('profile')
        ), (result) ->
        $scope.errors = []
        console.log ' 注册失败'
        console.log result
        for key, value of result
          $scope.errors.push v for v in value

    return
