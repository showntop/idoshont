angular.module "door"
  .controller "TopicController", ($scope, textAngularManager, topicService) ->

    $scope.topic =
      title: ''
      cooked: ''

    $scope.attachment =
      null

    $scope.upload =
      topicService.upload($scope.attachment)


    $scope.save = ->
      if $scope.topic.id == undefined then topicService.update($scope.topic)
      else
        topicService.create($scope.topic)

    $scope.publish = ->
      $scope.topic.publish = true
      topicService.update($scope.topic)