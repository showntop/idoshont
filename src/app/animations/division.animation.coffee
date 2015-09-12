angular.module('door').animation '.fragment', ($animate) ->
  #logic of animation
  enter: (element, done) ->
    console.log 'entering...'
    width = element.width()
    element.css
      position: 'relative'
      left: -10
      opacity: 0
    element.animate {
      left: 0
      opacity: 1
    }, done
    return
  leave: (element, done) ->
    element.css
      position: 'relative'
      left: 0
      opacity: 1
    element.animate {
      left: -10
      opacity: 0
    }, done
    return
  move: (element, done) ->
    element.css
      left: '2px'
      opacity: 0.5
    element.animate {
      left: '0px'
      opacity: 1
    }, done
    return