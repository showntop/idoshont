angular.module "door"
  .directive 'topicProfile', ->

    ProfileController = ($scope) ->
      $scope.userPopover =
        content: 'Hello, World!'
        templateUrl: 'app/components/user/user.popover.html'
        title: 'Title'

      $scope.userInfoVisiable = false
      $scope.toggleUserInfo = ->
        $scope.userInfoVisiable = !$scope.userInfoVisiable
      console.log 'me'

      $scope.triggerOveredUser = ->
        #$scope.$emit('overed-user', $scope.topic.user);

    directive =
      restrict: 'AE'
      templateUrl: 'app/components/topic/profile.html'
      scope: topic: '='
      controller: ProfileController
      replace: true
      link: (scope, element, attrs) ->
        console.log 'link'
        element.find('.description')[0].innerHTML = scope.topic.cooked
