angular.module "door"
  .directive 'categoryItem', ->

    CategoryItemController = ($scope) ->
      vm = this
      return

    directive =
      restrict: 'AE'
      templateUrl: 'app/components/categoryItem/category.item.html'
      scope: category: '='
      controller: CategoryItemController
      controllerAs: 'vm'
      replace: true
      link: (scope, element, attrs) -> 
            scope.showMe = false
            console.log scope