angular.module "door"
.controller "CategoryListController", ($rootScope, $scope, $http, $state, $stateParams, ngDialog, utils) ->

  $scope.categories = []

  $scope.currentCategory =
    name: '新分类'#utils.findById($scope.$parent.categories, Number($stateParams.id)) if $scope.hasOwnProperty('$parent')

  promise = $http
    method: 'get',
    url: '/api/categories.json',
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
    data: $scope.user
  promise.success (result,status,headers,config) ->
    console.log result
    if result.code == -1
      alert('失败')
    else
      $scope.categories = result.categories
    return
  promise.error (data,status,headers,config) ->
    console.log 'error'

  $scope.setCurrentCategory = (category) ->
    $scope.currentCategory = category
    ngDialog.open
      template: 'app/modules/category/detail.html'
      scope: $scope
      controller: 'CategoryController'
      className: 'ngdialog-theme-category'

  return
