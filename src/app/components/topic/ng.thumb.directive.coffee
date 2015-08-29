angular.module "door"
  .directive 'ngThumb', [
    '$window'
    ($window) ->
      helper = 
        support: ! !($window.FileReader and $window.CanvasRenderingContext2D)
        isFile: (item) ->
          angular.isObject(item) and item instanceof $window.File
        isImage: (file) ->
          type = '|' + file.type.slice(file.type.lastIndexOf('/') + 1) + '|'
          '|jpg|png|jpeg|bmp|gif|'.indexOf(type) != -1
      {
        restrict: 'A'
        template: '<canvas/>'
        link: (scope, element, attributes) ->

          onLoadFile = (event) ->
            img = new Image
            img.onload = onLoadImage
            img.src = event.target.result
            return

          onLoadImage = ->
            width = params.width or @width / @height * params.height
            height = params.height or @height / @width * params.width
            canvas.attr
              width: width
              height: height
            canvas[0].getContext('2d').drawImage this, 0, 0, width, height
            return

          if !helper.support
            return
          params = scope.$eval(attributes.ngThumb)
          if !helper.isFile(params.file)
            return
          if !helper.isImage(params.file)
            return
          canvas = element.find('canvas')
          reader = new FileReader
          reader.onload = onLoadFile
          reader.readAsDataURL params.file
          return

      }
  ]