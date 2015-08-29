angular.module "door"
  .run ($rootScope, $log) ->
    $log.debug 'runBlock end'
    $rootScope.global =
      isLogin: false
      user: {}

    $rootScope.logout = ->
      global.user = null
