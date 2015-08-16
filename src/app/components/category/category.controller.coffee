angular.module "door"
.controller "CategoryController", ($scope, categoryService) ->
  $scope.tabs = [
    {name: '基本', state: 'category.basic', src: 'app/components/category/partials/basic.html'}
    {name: '安全', state: 'category.safe', src: 'app/components/category/partials/safe.html'}
    {name: '显示', state: 'category.style', src: 'app/components/category/partials/style.html'}
  ]

  $scope.categories = categoryService.list
  $scope.saveCategory = ->
    if $scope.currentCategory.id then categoryService.updateCategory($scope.currentCategory)
    else categoryService.createCategory($scope.currentCategory)

  