angular.module "door"
  .controller "TopicController", ($scope, ngDialog, topicService, $modal) ->

    $scope.topic =
      title: ''
      cooked: ''

    $scope.currentAttachmentUrl =
      null

    $scope.upload =
      topicService.upload($scope.attachment)


    $scope.save = ->
      if $scope.topic.id == undefined then topicService.create($scope.topic)
      else
        topicService.update($scope.topic)

    $scope.publish = ->
      $scope.topic.publish = true
      if $scope.topic.id == undefined then topicService.create($scope.topic)
      else
        topicService.update($scope.topic)

    $scope.$on 'ngDialog.closed', (e, $dialog) ->
      console.log 'name'
      console.log('ngDialog colsed: ' + $dialog.attr('id'))
      $scope.editor.wrapSelection($scope.name, $scope.currentAttachmentUrl, true)
      $scope.finishFunction

    $scope.launch = (name, finishFunction, editor)->

      $scope.name = name
      $scope.finishFunction = finishFunction
      $scope.editor = editor

      upload = $scope.upload = ->
        return editor.wrapSelection('insertImage', 'http://images.china.cn/attachement/jpg/site1000/20150822/c03fd54abbac174208394e.jpg', true)

      modalInstance = ngDialog.open(
        templateUrl: 'app/components/topic/file.chooser.html'
        scope: $scope
        appendTo: '#topic-new-container'
        name: 'uploadImage'
        closeByDocument: true
        # resolve:
        #   name: name
        #   finishFunction: finishFunction
        #   wrapSelection: wrapSelection
        controller: 'FileChooserController'
          #return editor.wrapSelection('insertImage', 'http://images.china.cn/attachement/jpg/site1000/20150822/c03fd54abbac174208394e.jpg', true)

        # controller: ($scope, Upload)->
        #   $scope.$watch 'file', (file) ->
        #     if !file.$error
        #       $scope.upload $scope.file
        #     return
        #   $scope.upload = (file) ->
        #     Upload.upload(
        #       url: 'upload/url'
        #       fields: 'username': $scope.username
        #       file: file).progress((evt) ->
        #       progressPercentage = parseInt(100.0 * evt.loaded / evt.total)
        #       console.log 'progress: ' + progressPercentage + '% ' + evt.config.file.name
        #       return
        #     ).success((data, status, headers, config) ->
        #       console.log 'file ' + config.file.name + 'uploaded. Response: ' + data
        #       return
        #     ).error (data, status, headers, config) ->
        #       console.log 'error status: ' + status
        #       return
        #     return
      )

    ### optional: set default directive values ###

    #Upload.setDefaults( {ngf-keep:false ngf-accept:'image/*', ...} )

