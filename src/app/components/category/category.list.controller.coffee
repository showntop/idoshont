angular.module "door"
.controller "CategoryListController", ($rootScope, $scope, ngDialog, categoryService) ->

  $scope.categories = categoryService.list

  $scope.currentCategory =
    name: '新分类'#utils.findById($scope.$parent.categories, Number($stateParams.id)) if $scope.hasOwnProperty('$parent')
  

  $scope.openCategoryWin = (category) ->
    $scope.currentCategory = category
    ngDialog.open
      template: 'app/components/category/detail.html'
      scope: $scope
      controller: 'CategoryController'
      className: 'ngdialog-theme-category'

  return
