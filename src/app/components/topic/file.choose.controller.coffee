angular.module "door"
  .controller "FileChooserController", ($scope, FileUploader) ->
   
    uploader = $scope.uploader = new FileUploader(
      url: '/api/topic_attachments.json',
      alias: 'topic_attachment[attachment]'
      )
    # FILTERS
    uploader.filters.push
      name: 'imageFilter'
      fn: (item, options) ->
        type = '|' + item.type.slice(item.type.lastIndexOf('/') + 1) + '|'
        '|jpg|png|jpeg|bmp|gif|'.indexOf(type) != -1
    # CALLBACKS

    uploader.onWhenAddingFileFailed = (item, filter, options) ->
      console.info 'onWhenAddingFileFailed', item, filter, options
      return

    uploader.onAfterAddingFile = (fileItem) ->
      console.info 'onAfterAddingFile', fileItem
      return

    uploader.onAfterAddingAll = (addedFileItems) ->
      console.info 'onAfterAddingAll', addedFileItems
      return

    uploader.onBeforeUploadItem = (item) ->
      console.info 'onBeforeUploadItem', item
      return

    uploader.onProgressItem = (fileItem, progress) ->
      console.info 'onProgressItem', fileItem, progress
      return

    uploader.onProgressAll = (progress) ->
      console.info 'onProgressAll', progress
      return

    uploader.onSuccessItem = (fileItem, response, status, headers) ->
      console.info 'onSuccessItem', fileItem, response, status, headers
      return

    uploader.onErrorItem = (fileItem, response, status, headers) ->
      console.info 'onErrorItem', fileItem, response, status, headers
      return

    uploader.onCancelItem = (fileItem, response, status, headers) ->
      console.info 'onCancelItem', fileItem, response, status, headers
      return

    uploader.onCompleteItem = (fileItem, response, status, headers) ->
      console.log $scope
      console.info 'onCompleteItem', fileItem, response, status, headers
      #reset(response)
      $scope.$parent.currentAttachmentUrl = 'http://localhost:8000' + response.attachment_url
      $scope.closeThisDialog(response)
      return

    uploader.onCompleteAll = ->
      console.info 'onCompleteAll'
      return

    console.info 'uploader', uploader