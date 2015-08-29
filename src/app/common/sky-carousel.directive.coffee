angular.module "door"
  .directive 'skyCarousel', ->

    SkyCarouselController = ($scope) ->

      return

    directive =
      restrict: 'AE'
      templateUrl: 'app/common/sky-carousel/sky-carousel.html'
      scope: items: '='
      controller: SkyCarouselController
      compile: (element, attrs) ->
        console.log 'xxxxx'
        console.log 'xxxxxx'
      link: (scope, element, attrs) -> 
            console.log scope
            $('#sky-carousel').carousel(
              itemWidth: 300
              itemHeight: 450
              distance: 15
              selectedItemDistance: 50
            )
      transclude: true