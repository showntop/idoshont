angular.module "door"
  .controller "LoginController", ($rootScope, $scope, $http, $state) ->

    $scope.user = {}

    $scope.login = ->
      console.log('xxxx')
      promise = $http
        method: 'POST',
        url: '/api/sessions.json',
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
        data: $scope.user
      promise.success (result,status,headers,config) ->
        console.log result
        if result.code == -1
          alert('登录失败')
        else
          $rootScope.global.isLogin = true
          $rootScope.global.user = result.data
          $state.go('main')
        return
      promise.error (data,status,headers,config) ->
        console.log 'error'
      return
    return
