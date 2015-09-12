angular.module "door"
  .controller "UserProfileCtrl", ($scope, userService) ->

    $scope.userProfile = 
      name: ''
      gender: 
      location: ''
      bio: ''

    $scope.submit = (profile) ->
      $scope.currentUser
      userService.update(profile)
  
    return
