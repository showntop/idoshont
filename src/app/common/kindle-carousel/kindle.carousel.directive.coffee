# angular.module "door"
#   .directive 'kindleCarousel', ->

#     SKY = SKY or {}
#     SKY.Utils =
#       touchSupport: null
#       canvasSupport: null
#       transformation2dSupport: null
#       transformation3dSupport: null
#       transitionSupport: null
#       prefixedProps: []
#       hasTouchSupport: ->
#         null == @touchSupport and (@touchSupport = Modernizr.touch)
#         @touchSupport
#       hasCanvasSupport: ->
#         null == @canvasSupport and (@canvasSupport = Modernizr.canvas)
#         @canvasSupport
#       has2dTransformationSupport: ->
#         null == @transformation2dSupport and (@transformation2dSupport = Modernizr.csstransforms)
#         @transformation2dSupport
#       has3dTransformationSupport: ->
#         null == @transformation3dSupport and (@transformation3dSupport = Modernizr.csstransforms3d)
#         @transformation3dSupport
#       hasTransitionSupport: ->
#         null == @transitionSupport and (@transitionSupport = Modernizr.csstransitions)
#         @transitionSupport
#       getPrefixedProperty: (a) ->
#         undefined == @prefixedProps[a] and (@prefixedProps[a] = Modernizr.prefixed(a))
#         @prefixedProps[a]
#       setCursor: (a) ->
#         switch a
#           when 'openhand'
#             $('body').css 'cursor', 'url(images/sc-graphics/openhand.cur), auto'
#           when 'closedhand'
#             $('body').css 'cursor', 'url(images/sc-graphics/closedhand.cur), auto'
#           else
#             $('body').css 'cursor', a
#         return
#       hexToRGB: (a) ->
#         '#' == a[0] and (a = a.substr(1))
#         if 3 == a.length
#           b = /^([a-f\d])([a-f\d])([a-f\d])$/i.exec(a).slice(1)
#           a = ''
#           c = 0
#           while 3 > c
#             a += b[c] + b[c]
#             c++
#         b = /^([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(a).slice(1)
#         {
#           r: parseInt(b[0], 16)
#           g: parseInt(b[1], 16)
#           b: parseInt(b[2], 16)
#         }
#     window.requestAnimFrame = do ->
#       window.requestAnimationFrame or window.webkitRequestAnimationFrame or window.mozRequestAnimationFrame or window.oRequestAnimationFrame or window.msRequestAnimationFrame or (a) ->
#         window.setTimeout a, 1E3 / 60
#         return

#     SKY.ImageLoader = (a) ->
#       @subscribers = []
#       @img = a
#       @fired = !1
#       return

#     SKY.ImageLoader.prototype =
#       subscribe: (a) ->
#         @subscribers.push a
#         return
#       unsubscribe: (a) ->
#         b = 0
#         while b < @subscribers.length
#           @subscribers[b] == a and delete @subscribers[b]
#           b++
#         return
#       publish: ->
#         if !@fired
#           @fired = !0
#           a = 0
#           while a < @subscribers.length
#             if 'function' == typeof @subscribers[a]
#               @subscribers[a]()
#             a++
#         return
#       load: ->
#         a = this
#         if @img.addEventListener then @img.addEventListener('load', ((b) ->
#           a.onLoad b
#           return
#         ), !1) else @img.attachEvent and @img.attachEvent('onload', ((b) ->
#           a.onLoad b
#           return
#         ))
#         if @img.complete or undefined == @img.complete or 'loading' == @img.readyState
#           b = @img.src
#           @img.src = 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw=='
#           @img.src = b
#         return
#       onLoad: (a) ->
#         1 < @img.height and @publish()
#         return

#     SKY.Timer = (a, b) ->
#       @delay = a or 2E3
#       @repeatCount = b or 0
#       @currentCount = 0
#       @intervalID = null
#       @running = !1
#       @subscribers = []
#       return

#     SKY.Timer.prototype =
#       subscribe: (a) ->
#         @subscribers.push a
#         return
#       unsubscribe: (a) ->
#         b = 0
#         while b < @subscribers.length
#           @subscribers[b] == a and delete @subscribers[b]
#           b++
#         return
#       publish: (a) ->
#         b = 0
#         while b < @subscribers.length
#           if 'function' == typeof @subscribers[b]
#             @subscribers[b] a
#           b++
#         return
#       reset: ->
#         @currentCount = 0
#         return
#       start: ->
#         a = this
#         @running or @intervalID = setInterval((->
#           a.tick()
#           return
#         ), @delay)
#         @running = !0
#         return
#       stop: ->
#         @running and clearInterval(@intervalID)
#         @running = !1
#         return
#       tick: ->
#         ++@currentCount
#         @publish 'timer'
#         @currentCount == @repeatCount and @reset()
#         @stop()
#         @publish('timercomplete')
#         return

#     SKY.CarouselItem = (a, b) ->
#       @element = a
#       @carousel = b
#       @actualWidth = b.settings.itemWidth
#       @actualHeight = b.settings.itemHeight
#       @scaledY = @scaledX = @y = @x = 0
#       @alpha = @scale = 1
#       @width = @actualWidth
#       @height = @actualHeight
#       @zIndex = @baseOffset = 0
#       @distance = -1
#       @extraImageSize = @extraItemSize = 0
#       @url = a.children('a')
#       @imageElement = a.find('img')
#       @image = @imageElement.get(0)
#       @content = a.children('.sc-content')
#       @subscribers = load: []
#       @loaded = !1
#       @reflection = null
#       @init()
#       return

#     SKY.CarouselItem.prototype =
#       init: ->
#         if !1 == $.support.leadingWhitespace
#           a = 2 * parseInt(@imageElement.css('padding-left'))
#           b = 2 * parseInt(@imageElement.css('border-left-width'))
#           c = 2 * parseInt(@element.css('padding-left'))
#           d = 2 * parseInt(@element.css('border-left-width'))
#           @extraImageSize = a + b
#           @extraItemSize = c + d
#         @updateBaseOffset()
#         return
#       load: ->
#         a = this
#         if !@loaded
#           b = new (SKY.ImageLoader)(@image)
#           b.subscribe ->
#             a.onImageLoaded()
#             return
#           b.load()
#         return
#       subscribe: (a, b) ->
#         @subscribers[a].push b
#         return
#       unsubscribe: (a, b) ->
#         c = 0
#         while c < @subscribers[a].length
#           @subscribers[a][c] == b and delete @subscribers[a][c]
#           c++
#         return
#       publish: (a, b) ->
#         c = 0
#         while c < @subscribers[a].length
#           if 'function' == typeof @subscribers[a][c]
#             @subscribers[a][c] b
#           c++
#         return
#       index: ->
#         @element.index()
#       onImageLoaded: ->
#         a = @carousel.settings
#         @carousel.settings.reflectionVisible and @reflection = SKY.CarouselItem.createReflection(@imageElement, a.reflectionSize, a.reflectionAlpha)
#         @reflection.css(
#           'float': 'left'
#           clear: 'both'
#           'margin-top': a.reflectionDistance + 'px')
#         @element.append(@reflection)
#         @update()
#         @loaded = !0
#         @publish 'load', this
#         return
#       setAlpha: (a) ->
#         a != @alpha and @alpha = a
#         @update()
#         return
#       setX: (a) ->
#         a != @x and @scaledX += a - (@x)
#         @x = a
#         @update()
#         return
#       setY: (a) ->
#         a != @y and @scaledY += a - (@y)
#         @y = a
#         @update()
#         return
#       setXY: (a, b) ->
#         a != @x and b != @y and @scaledX += a - (@x)
#         @scaledY += b - (@y)
#         @x = a
#         @y = b
#         @update()
#         return
#       setScale: (a) ->
#         a != @scale and @scale = a
#         @update()
#         return
#       setDistance: (a) ->
#         @distance = a
#         return
#       setZIndex: (a) ->
#         a != @zIndex and @zIndex = a
#         @element.css('z-index', a)
#         return
#       getBaseOffset: ->
#         @baseOffset
#       updateBaseOffset: ->
#         a = @carousel.settings
#         @baseOffset = @index() * (a.itemWidth * a.unselectedItemZoomFactor + a.distance)
#         return
#       update: ->
#         a = @carousel.settings
#         if SKY.Utils.has2dTransformationSupport()
#           a = 'translate(' + @x + 'px, ' + @y + 'px) scale(' + @scale + ')'
#           SKY.Utils.has3dTransformationSupport() and (a += ' translateZ(0)')
#           @element.css(SKY.Utils.getPrefixedProperty('transform'), a)
#           @element.css('opacity', @alpha)
#         else
#           b = @actualWidth * @scale
#           c = @actualHeight * @scale
#           @scaledX = @x + (@actualWidth - b) / 2
#           @scaledY = @y + (@actualHeight - c) / 2
#           @width = b
#           @height = c
#           b =
#             left: @scaledX
#             top: @scaledY
#             width: @width - (@extraItemSize)
#             height: @height - (@extraItemSize)
#           c =
#             width: b.width - (@extraImageSize)
#             height: b.height - (@extraImageSize)
#           if a.reflectionVisible and !SKY.Utils.hasCanvasSupport() then c.opacity = @alpha
#           @reflection.css(
#             width: b.width
#             height: b.height
#             filter: SKY.CarouselItem.getAlphaFilterStatement(a.reflectionAlpha, a.reflectionSize, a.itemHeight))
#      else (b.opacity = @alpha)
#           @element.css b
#           @imageElement.css c
#         return
#       launchURL: ->
#         if 0 < @url.length
#           a = @url.attr('target')
#           window.open @url.attr('href'), if a then a else '_self'
#         return
#       addClass: (a) ->
#         @element.addClass a
#         return
#       removeClass: (a) ->
#         @element.removeClass a
#         return

#     SKY.CarouselItem.createReflection = (a, b, c) ->
#       d = a.width()
#       g = a.height()
#       f = null
#       if SKY.Utils.hasCanvasSupport() then f = $('<canvas>')
#       ctx = f.get(0).getContext('2d')
#       f.attr(
#         width: d
#         height: b)
#       f.addClass('reflection')
#       ctx.save()
#       ctx.translate(0, g)
#       ctx.scale(1, -1)
#       ctx.drawImage(a.get(0), 0, 0, d, g)
#       ctx.restore()
#       ctx.globalCompositeOperation = 'destination-out'
#       a = ctx.createLinearGradient(0, 0, 0, b)
#       a.addColorStop(0, 'rgba(0, 0, 0, ' + 1 - c + ')')
#       a.addColorStop(1, 'rgba(0, 0, 0, 1.0)')
#       ctx.fillStyle = a
#       ctx.fillRect(0, 0, d, b)
#      else f = $('<img>')
#       f.attr(src: a.get(0).src)
#       f.css('filter', SKY.CarouselItem.getAlphaFilterStatement(c, b, g))
#       f

#     SKY.CarouselItem.getAlphaFilterStatement = (a, b, c) ->
#       'flipv progid:DXImageTransform.Microsoft.Alpha(opacity=' + 100 * a + ', style=1, finishOpacity=0, startx=0, starty=0, finishx=0, finishy=' + 100 * b / c + ')'

#     SKY.Container = (a, b) ->
#       @element = a
#       @carousel = b
#       @x = 0
#       return

#     SKY.Container.prototype =
#       setX: (a, b) ->
#         @x = a
#         @update b
#         return
#       getLeft: ->
#         @element.position().left
#       setTopMargin: (a) ->
#         b = @carousel.settings
#         c = b.itemHeight
#         'auto' == a and (a = (@carousel.dom.carousel.height() - (c * b.selectedItemZoomFactor)) / 2)
#         a = -c * (1 - (b.selectedItemZoomFactor)) / 2 + a
#         @element.css 'margin-top', a + 'px'
#         return
#       update: (a) ->
#         b = this
#         if a then @carousel.onSelectionAnimationStart()
#         @element.on('webkitTransitionEnd transitionend oTransitionEnd otransitionend MSTransitionEnd', ((a) ->
#           b.element.off 'webkitTransitionEnd transitionend oTransitionEnd otransitionend MSTransitionEnd'
#           b.carousel.onSelectionAnimationEnd()
#           return
#         ))
#         if SKY.Utils.hasTransitionSupport() then @element.css(SKY.Utils.getPrefixedProperty('transition'), 'left ' + a + 's ease-out')
#         @element.css('left', @x)
#      else @element.stop().animate({ left: @x }, 1E3 * a, (->
#           b.carousel.onSelectionAnimationEnd()
#           return
#         ))
#      else SKY.Utils.hasTransitionSupport() and @element.css(SKY.Utils.getPrefixedProperty('transition'), '')
#         @element.stop().css(left: @x)
#         return

#     SKY.Carousel = (a, b) ->
#       @settings =
#         itemWidth: 300
#         itemHeight: 450
#         distance: 15
#         startIndex: 'auto'
#         enableKeyboard: !0
#         enableMouseWheel: !0
#         reverseMouseWheel: !1
#         autoSlideshow: !1
#         autoSlideshowDelay: 2.5
#         loop: !0
#         selectedItemDistance: 50
#         selectedItemZoomFactor: 1
#         unselectedItemZoomFactor: 0.6
#         unselectedItemAlpha: 0.6
#         motionStartDistance: 150
#         topMargin: 30
#         preload: !0
#         showPreloader: !0
#         navigationButtonsVisible: !0
#         gradientStartPoint: 0.15
#         gradientEndPoint: 1
#         gradientOverlayVisible: !0
#         gradientOverlayColor: '#fff'
#         gradientOverlaySize: 215
#         reflectionVisible: !1
#         reflectionDistance: 4
#         reflectionSize: 100
#         reflectionAlpha: 0.38
#         slideSpeed: 0.45
#         selectByClick: !1
#       b and $.extend(@settings, b)
#       @targetLeft = 0
#       @dragging = @mouseOver = !1
#       @extraDistanceUnit = @scaleUnit = @alphaUnit = @centerY = @centerX = @timer = @preloader = @contentContainer = @container = @closestItem = @selectedItem = null
#       @carouselItems = []
#       @dom = carousel: a
#       @events = {}
#       @init()

#     SKY.Carousel.prototype =
#       init: ->
#         @initDOM()
#         @initConfigParams()
#         @initEvents()
#         @initContentWrapper()
#         @initContainer()
#         @initGradientOverlays()
#         @initNavigationButtons()
#         @initResizeListener()
#         @initKeyboardNavigation()
#         @initMouseWheelSupport()
#         @initAutoSlideshow()
#         @calculateUnits()
#         @update()
#         @dom.carousel.css 'visibility', 'visible'
#         return
#       initDOM: ->
#         a = @settings
#         @dom.document = $(document)
#         @dom.wrapper = @dom.carousel.children('.sky-carousel-wrapper')
#         @dom.container = @dom.wrapper.children('.sky-carousel-container')
#         @dom.items = @dom.container.children('li')
#         @dom.links = @dom.container.find('li > a')
#         @dom.images = @dom.container.find('li img')
#         @dom.carousel.addClass 'sc-no-select'
#         a.preload and `!1 != $.support.leadingWhitespace` and @dom.wrapper.css(
#           visibility: 'hidden'
#           opacity: 0)
#         a.showPreloader and @preloader = $('<div class="sc-preloader"></div>')
#         @dom.carousel.append(@preloader)

#         @dom.links.click (a) ->
#           a.preventDefault()
#           !1
#         @dom.images.each ->
#           $(this).addClass 'sc-image'

#           @ondragstart = ->
#             !1

#           return
#         return
#       initConfigParams: ->
#         a = @settings
#         b = parseInt(@dom.items.css('padding-left'))
#         c = parseInt(@dom.items.css('border-left-width'))
#         d = parseInt(@dom.images.css('padding-left'))
#         g = parseInt(@dom.images.css('border-left-width'))
#         a.itemWidth += 2 * (b + c + d + g)
#         a.itemHeight += 2 * (b + c + d + g)
#         SKY.Utils.has2dTransformationSupport() and @dom.items.css(SKY.Utils.getPrefixedProperty('transformOrigin'), 'center ' + Math.round(a.itemHeight / 2) + 'px')
#         return
#       initEvents: ->
#         if SKY.Utils.hasTouchSupport() then @events.startEvent = 'touchstart.sc'
#         @events.moveEvent = 'touchmove.sc'
#         @events.endEvent = 'touchend.sc'
#         @events.touchCancel = 'touchcancel.sc'
#      else @events.startEvent = 'mousedown.sc'
#         @events.moveEvent = 'mousemove.sc'
#         @events.endEvent = 'mouseup.sc'
#         return
#       initContainer: ->
#         a = this
#         b = 0
#         @container = new (SKY.Container)(@dom.container, this)
#         @dom.items.each (c) ->
#           c = new (SKY.CarouselItem)($(this), a)
#           c.subscribe 'load', (c) ->
#             ++b
#             if `b == a.dom.items.length`
#               a.onAllLoaded()
#             return
#           c.load()
#           a.carouselItems.push c
#           return
#         @dom.carousel.on @events.startEvent, (b) ->
#           a.onStart b
#           return
#         SKY.Utils.hasTouchSupport() or @dom.carousel.hover(((b) ->
#           a.mouseOver = !0
#           a.updateCursor()
#           return
#         ), (b) ->
#           a.mouseOver = !1
#           a.updateCursor()
#           return
#         )
#         @selectedItem = @getStartItem()
#         @selectedItem.addClass 'sc-selected'
#         @updatePlugin()
#         return
#       initGradientOverlays: ->
#         `var a`
#         a = @settings
#         if a.gradientOverlayVisible
#           b = @createGradientOverlay('left', a.gradientStartPoint, a.gradientEndPoint, a.gradientOverlayColor, a.gradientOverlaySize)
#           a = @createGradientOverlay('right', a.gradientStartPoint, a.gradientEndPoint, a.gradientOverlayColor, a.gradientOverlaySize)
#           @dom.carousel.append b
#           @dom.carousel.append a
#         return
#       initContentWrapper: ->
#         a = $('<div class="sc-content-wrapper"></div>')
#         @contentContainer = $('<div class="sc-content-container"></div>')
#         @contentContainer.append '<div class="sc-content"><h2></h2><p></p></div>'
#         a.append @contentContainer
#         `!1 != $.support.leadingWhitespace` and @settings.preload and @contentContainer.css(
#           visibility: 'hidden'
#           opacity: 0)
#         @dom.carousel.append a
#         return
#       initNavigationButtons: ->
#         a = this
#         if @settings.navigationButtonsVisible
#           b = $('<a href="#" class="sc-nav-button sc-prev sc-no-select"></a>')
#           c = $('<a href="#" class="sc-nav-button sc-next sc-no-select"></a>')
#           @dom.carousel.append b
#           @dom.carousel.append c
#           b.on 'click', (b) ->
#             b.preventDefault()
#             a.selectPrevious a.settings.slideSpeed
#             return
#           c.on 'click', (b) ->
#             b.preventDefault()
#             a.selectNext a.settings.slideSpeed
#             return
#         return
#       initResizeListener: ->
#         a = this
#         $(window).on 'resize', (b) ->
#           a.updatePlugin b
#           return
#         return
#       initKeyboardNavigation: ->
#         a = this
#         `s = this.settings`
#         s.enableKeyboard and @dom.document.keydown((b) ->
#           if `'textarea' != b.target.type` and `'text' != b.target.type`
#             switch b.keyCode
#               when 37
#                 a.selectPrevious s.slideSpeed
#               when 39
#                 a.selectNext s.slideSpeed
#           return
#         )
#         return
#       initMouseWheelSupport: ->
#         a = this
#         b = @settings
#         c = @dom.carousel.get(0)
#         if b.enableMouseWheel

#           d = (c) ->
#             `var d`
#             d = 0
#             if c.preventDefault then c.preventDefault() else c.returnValue = !1
#             c.cancelBubble = !0
#             if c.wheelDelta then (d = c.wheelDelta / 120) else c.detail and (d = -c.detail / 3)
#             b.reverseMouseWheel and (d *= -1)
#             if 0 < d then a.selectPrevious(b.slideSpeed) else 0 > d and a.selectNext(b.slideSpeed)
#             return

#           if c.addEventListener then c.addEventListener('mousewheel', d, !1)
#           c.addEventListener('DOMMouseScroll', d, !1)
#      else c.attachEvent and c.attachEvent('onmousewheel', d)
#         return
#       initAutoSlideshow: ->
#         @settings.autoSlideshow and @startAutoSlideshow()
#         return
#       startAutoSlideshow: ->
#         a = this
#         b = @settings
#         @timer or @timer = new (SKY.Timer)(1E3 * b.autoSlideshowDelay)
#         @timer.subscribe((c) ->
#           if a.selectedItem.index() < a.carouselItems.length - 1 then a.selectNext(b.slideSpeed) else b.loop and a.select(a.carouselItems[0], b.slideSpeed)
#           return
#         )
#         @timer.start()
#         return
#       stopAutoSlideshow: ->
#         @timer and @timer.stop()
#         return
#       onClosestChanged: (a) ->
#         @setCurrentContent a
#         @dom.carousel.trigger
#           type: 'closestItemChanged.sc'
#           item: a
#         return
#       setCurrentContent: (a) ->
#         if 0 < a.content.length then @contentContainer.find('h2').html(a.content.children('h2').html())
#         @contentContainer.find('p').html(a.content.children('p').html())
#      else @contentContainer.find('h2').empty()
#         @contentContainer.find('p').empty()
#         return
#       getStartItem: ->
#         a = @settings.startIndex
#         `'auto' == a` and (a = Math.round(@carouselItems.length / 2) - 1)
#         @carouselItems[a]
#       zSort: (a) ->
#         b = @carouselItems.length
#         a.sort (a, b) ->
#           a.distance - (b.distance)
#         c = 0
#         while c < a.length
#           a[c].setZIndex(b)
#           --b
#           c++
#         a[0] and `this.closestItem != a[0]` and @closestItem = a[0]
#         @onClosestChanged(@closestItem)
#         a = null
#         return
#       select: (a, b) ->
#         c = @settings
#         if `'number' == typeof a`
#           d = @carouselItems[a]
#         else
#           `'object' == typeof a` and (d = a)
#         @selectedItem and @selectedItem.removeClass('sc-selected')
#         d.addClass 'sc-selected'
#         @selectedItem = d
#         c = @selectedItem.getBaseOffset() + c.itemWidth / 2 + c.selectedItemDistance
#         @container.setX @centerX - c, b
#         @dom.carousel.trigger
#           type: 'itemSelected.sc'
#           item: @selectedItem
#         return
#       selectNext: (a) ->
#         b = @selectedItem.index()
#         `b == this.carouselItems.length - 1` and (b = -1)
#         @select b + 1, a
#         return
#       selectPrevious: (a) ->
#         b = @selectedItem.index()
#         `0 == b` and (b = @carouselItems.length)
#         @select b - 1, a
#         return
#       calculateUnits: ->
#         a = @settings
#         @alphaUnit = (1 - (a.unselectedItemAlpha)) / a.motionStartDistance
#         @scaleUnit = (a.selectedItemZoomFactor - (a.unselectedItemZoomFactor)) / a.motionStartDistance
#         @extraDistanceUnit = a.selectedItemDistance / a.motionStartDistance
#         return
#       update: ->
#         a = this
#         b = @settings
#         c = @container
#         d = c.getLeft()
#         g = []
#         f = 0
#         while f < @carouselItems.length
#           e = @carouselItems[f]
#           h = d + e.x + b.itemWidth / 2 - (@centerX)
#           k = Math.abs(h)
#           if k <= b.motionStartDistance
#             p = @calculateAlpha(k)
#             l = @calculateScale(k)
#             n = @calculateExtraDistance(k)
#           else
#             p = b.unselectedItemAlpha
#             l = b.unselectedItemZoomFactor
#             n = 0
#           k <= @centerX and e.setDistance(k)
#           g.push(e)
#           e.setAlpha p
#           e.setScale l
#           if 0 < h then e.setX(e.getBaseOffset() + 2 * b.selectedItemDistance - n) else e.setX(e.getBaseOffset() + n)
#           h = k = p = l = n = null
#           f++
#         @zSort g
#         @dragging and c.setX(@targetLeft)
#         window.requestAnimFrame ->
#           a.update()
#           return
#         return
#       updatePlugin: ->
#         a = @dom.carousel.width()
#         b = @dom.carousel.height()
#         @centerX = Math.floor(a / 2)
#         @centerY = Math.floor(b / 2)
#         @updateLayout()
#         return
#       updateLayout: ->
#         a = @settings
#         b = @selectedItem.index()
#         @container.setTopMargin a.topMargin
#         c = 0
#         while c < @carouselItems.length
#           d = @carouselItems[c]
#           g = 0
#           d.updateBaseOffset()
#           if `c == b` then (g = a.selectedItemDistance) else c > b and (g = 2 * a.selectedItemDistance)
#           d.setX d.getBaseOffset() + g
#           d.setScale a.unselectedItemZoomFactor
#           c++
#         @selectedItem.setScale a.selectedItemZoomFactor
#         @container.setX @centerX - (@selectedItem.x) - (a.itemWidth / 2)
#         return
#       updateCursor: ->
#         if @dragging then SKY.Utils.setCursor('closedhand') else if @mouseOver then SKY.Utils.setCursor('openhand') else SKY.Utils.setCursor('auto')
#         return
#       calculateAlpha: (a) ->
#         (@settings.motionStartDistance - a) * @alphaUnit + @settings.unselectedItemAlpha
#       calculateScale: (a) ->
#         (@settings.motionStartDistance - a) * @scaleUnit + @settings.unselectedItemZoomFactor
#       calculateExtraDistance: (a) ->
#         Math.ceil (@settings.motionStartDistance - a) * @extraDistanceUnit
#       onStart: (a) ->

#         b = (a) ->
#           `var b`
#           b = a.originalEvent
#           c = if SKY.Utils.hasTouchSupport() then b.touches[0].clientX else a.clientX
#           g = if SKY.Utils.hasTouchSupport() then b.touches[0].clientY else a.clientY
#           r = (c - startX) / 2 + n
#           `m = e - c`
#           `e = c`
#           if SKY.Utils.hasTouchSupport()
#             if 1 < b.touches.length
#               `q = !0`
#               return
#             t or `t = !0`
#             if Math.abs(g - h) > Math.abs(c - startX) + 5 then (d.isScrolling = !0) else (d.isScrolling = !1)
#             if d.isScrolling
#               `q = !0`
#               return
#           a.preventDefault()
#           r > p + 40 and (r = p + 40 + 0.2 * (r - p))
#           r < l - 40 and (r = l - 40 - (0.2 * (l - r)))
#           d.dragging or d.dragging = !0
#           d.updateCursor()
#           d.targetLeft = r
#           return

#         c = (a) ->
#           `var e`
#           e = a.originalEvent
#           f = if SKY.Utils.hasTouchSupport() then e.changedTouches[0].clientX else a.clientX
#           a = if SKY.Utils.hasTouchSupport() then e.changedTouches[0].clientY else a.clientY
#           e = Math.round(m / 20)
#           h = d.closestItem.index()
#           d.timer and d.timer.start()
#           d.dom.document.off d.events.moveEvent, b
#           d.dom.document.off d.events.endEvent, c
#           d.events.touchCancel and d.dom.document.off(d.events.touchCancel, c)
#           if `0 == Math.abs(startX - f)` then f = $(document.elementFromPoint(f, a))
#           if f.hasClass('sc-image') then f.parent().is('a') and (f = f.parent())
#           f = d.carouselItems[f.parent().index()]
#           if g.selectByClick and `f != d.selectedItem` then d.select(f, g.slideSpeed) else if g.selectByClick and `f == d.selectedItem` then d.selectNext(g.slideSpeed) else f.launchURL()
#      else g.selectByClick and d.selectNext(g.slideSpeed)
#      else `0 == e` and 0 < Math.abs(m) and `d.closestItem.index() == d.selectedItem.index()` and (e = if 0 < m then 1 else if 0 > m then -1 else 0)
#           h += e
#           h = if 0 > h then 0 else if h > k - 1 then k - 1 else h
#           !u and !q and d.select(h, g.slideSpeed)
#           d.dragging = !1
#           d.updateCursor()
#           return

#         if `'A' != a.target.nodeName`
#           d = this
#           g = @settings
#           f = a.originalEvent
#           e = `startX = SKY.Utils.hasTouchSupport() ? f.targetTouches[0].clientX : a.clientX`
#           h = if SKY.Utils.hasTouchSupport() then f.targetTouches[0].clientY else a.clientY
#           k = @carouselItems.length
#           p = d.centerX - (g.selectedItemDistance + g.itemWidth / 2)
#           l = p - ((g.itemWidth * g.unselectedItemZoomFactor + g.distance) * (k - 1))
#           n = @container.getLeft()
#           m = 0
#           t = !1
#           q = !1
#           u = !1
#           @timer and @timer.stop()
#           @dom.document.on @events.moveEvent, b
#           @dom.document.on @events.endEvent, c
#           if @events.touchCancel
#             @dom.document.on @events.touchCancel, c
#           if SKY.Utils.hasTouchSupport() then 1 < f.touches.length and (q = !0) else a.preventDefault()
#         return
#       onAllLoaded: ->
#         a = this
#         b = @settings
#         if `!1 != $.support.leadingWhitespace`

#           c = ->
#             a.dom.wrapper.css 'visibility', 'visible'
#             a.dom.wrapper.animate { opacity: 1 }, 700
#             a.contentContainer.css 'visibility', 'visible'
#             a.contentContainer.animate { opacity: 1 }, 700
#             return

#           b.preload and (if b.showPreloader then @preloader.fadeOut(700, c) else c())
#         return
#       on: (a, b) ->
#         @dom.carousel.on a, null, null, b
#         return
#       onSelectionAnimationStart: ->
#         @dom.carousel.trigger
#           type: 'selectionAnimationStart.sc'
#           item: @selectedItem
#         return
#       onSelectionAnimationEnd: ->
#         @dom.carousel.trigger
#           type: 'selectionAnimationEnd.sc'
#           item: @selectedItem
#         return
#       createGradientOverlay: (a, b, c, d, g) ->
#         if SKY.Utils.hasCanvasSupport()
#           f = $('<canvas class="sc-overlay" width="' + g + '" height="1"></canvas')
#           e = f.get(0).getContext('2d')
#           d = SKY.Utils.hexToRGB(d)
#           h = null
#           f.css 'width', g + 'px'
#           f.addClass 'sc-overlay-' + a
#           if `'left' == a` then (h = e.createLinearGradient(0, 0, g, 0)) else `'right' == a` and (h = e.createLinearGradient(g, 0, 0, 0))
#           h.addColorStop b, 'rgba(' + d.r + ', ' + d.g + ', ' + d.b + ', 1.0)'
#           h.addColorStop c, 'rgba(' + d.r + ', ' + d.g + ', ' + d.b + ', 0)'
#           e.fillStyle = h
#           e.fillRect 0, 0, g, 1
#           return f


#     KindleCarouselCtrl = ($scope, $element, $animate) ->
#       self = this
#       slides = self.slides = $scope.slides = []
#       self.currentSlide = null

#       self.select = $scope.select = (nextSlide, direction)->
#         null

#       goNext = (slide, index, directive)->

#     directive =
#       restrict: 'AE'
#       transclude: true
#       replace: true
#       templateUrl: (element, attrs) ->
#         return attrs.templateUrl || 'app/common/kindle-carousel/kindle.carousel.html'
#       scope: {

#       }
#       controller: KindleCarouselCtrl
#       compile: (element, attrs) ->
#         console.log 'compile'
#       link: (scope, element, attrs) -> 
#         console.log 'link'


#   .directive 'kindleSlide', ->

#     directive = 
#       require: '^kindleCarousel'
#       restrict: 'EA'
#       transclude: true
#       replace: true
#       templateUrl: (element, attrs)->
#         return attrs.templateUrl || 'template/carousel/slide.html'
#       scope: {

#       }
#       link: (scope, element, attrs, KindleCarouselCtrl)->
