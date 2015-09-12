angular.module "door"
  .controller "ApplicationCtrl", ($scope) ->

    $scope.currentUser = null
    $scope.userRoles = []#USER_ROLES
    $scope.isAuthorized = ->#AuthService.isAuthorized
      return $scope.currentUser

    $scope.setCurrentUser = (user) ->
      $scope.currentUser = user

    return
