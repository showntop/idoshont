angular.module "door"
  .directive 'topicProfile', ->

    ProfileController = ($scope) ->
      console.log 'me'
    directive =
      restrict: 'AE'
      templateUrl: 'app/components/topic/topic.profile.html'
      scope: topic: '='
      controller: ProfileController
      link: (scope, element, attrs) ->
        console.log 'xxxxx'
        element[0].children[0].children[1].innerHTML = scope.topic.cooked
