angular.module "door"
  .config ($provide) ->

    $provide.decorator 'taTools', ['$delegate', '$http', (taTools, taOptions, $http) ->
      taTools.bold =
        display: '<div><i class="fa fa-bold"></i></div>'
      taTools.pre.display = '<div>pre</div>'
      taTools.italics.display = '<div><i class="fa fa-italic"/></div>'
      taTools.underline.display = '<div><i class="fa fa-underline"/></div>'
      taTools.ul.display = '<div><i class="fa fa-list-ul"></i></div>'
      taTools.ol.display = '<div><i class="fa fa-list-ol"></i></div>'
      taTools.undo.display = '<div><i class="fa fa-undo"></i></div>'
      taTools.redo.display = '<div><i class="fa fa-repeat"></i></div>'
      taTools.justifyLeft.display = '<div><i class="fa fa-align-left"></i></div>'
      taTools.justifyRight.display = '<div><i class="fa fa-align-right"></i></div>'
      taTools.justifyCenter.display = '<div><i class="fa fa-align-center"></i></div>'
      taTools.clear.display = '<div><i class="fa fa-ban"></i></div>'
      taTools.insertLink.display = '<div><i class="fa fa-link"/></div>'
      #taTools.unlink.display = '<div></div>'
      taTools.insertImage = 
        display: '<div style=""><i class="fa fa-picture-o" style="position: relative; left: 6px;"/><form id="xxx" method="post" action="/api/topic_attachments.json" style="position: relative; left: -20px; display: inline; width: 100%; height: 100%;"><input name="topic_attachment[attachment]" id="file-input" type="file"></form></div>'
        # display: '<div><i class="fa fa-picture-o"/></div>'
        action: ->
          console.log 'fdfdsf'
          $('#file-input').bind "change", (changeEvent) ->
            console.log 'change'
            if(changeEvent.target.files.length > 0)
              file = changeEvent.target.files[0]
              xxx.submit( (data)->
                imageLink = data.src
                if(imageLink && imageLink != '' && imageLink != 'http://')
                  return this.$editor().wrapSelection('insertImage', imageLink, true)
              )
              #topicService.upload(file)
            else
              return
        
      # there is no quote icon in old font-awesome so we change to text as follows
      #delete taTools.quote.display
      #taTools.quote.buttontext = 'quote'
      taTools.quote.display = '<div><i class="fa fa-quote-right"></i></div>'
      taTools.strikeThrough.display = '<div><i class="fa fa-strikethrough"/></div>'
      taTools.html.display = '<div><i class="fa fa-code"></i></div>'
      taTools.insertVideo.display = '<div><i class="fa fa-youtube-play"></i></div>'

      return taTools;
    ]

    $provide.decorator 'taOptions', [
      'taRegisterTool'
      '$delegate'
      (taRegisterTool, taOptions) ->

        taOptions.toolbar = [
          ['pre', 'quote', 'bold', 'italics', 'underline', 'strikeThrough', 'ul', 'ol'],
          ['html','insertLink', 'insertVideo', 'insertImage'],
          [ 'redo', 'undo', 'clear']
        ]

        # $delegate is the taOptions we are decorating

        taRegisterTool 'emoji',
          display: '<div></div>'
          iconclass: 'fa fa-emoji'
          action: ->
            alert('弹出我')
            return
        # add the button to the default toolbar definition
        taOptions.toolbar[1].push 'emoji'

        taOptions.classes =
          focussed: "focussed"
          toolbar: ""
          toolbarGroup: ""
          toolbarButton: "toolbar-button"
          toolbarButtonActive: "active"
          disabled: "disabled"
          textEditor: 'form-control'
          htmlEditor: 'form-control'
        taOptions
    ]
