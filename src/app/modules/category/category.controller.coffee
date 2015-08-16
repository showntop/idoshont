angular.module "door"
.controller "CategoryController", ($scope, $http, $state) ->
  $scope.tabs = [
    {name: '基本', state: 'category.basic', src: 'app/modules/category/partials/basic.html'}
    {name: '安全', state: 'category.safe', src: 'app/modules/category/partials/safe.html'}
    {name: '显示', state: 'category.style', src: 'app/modules/category/partials/style.html'}
  ]
  $scope.saveCategory = ->
    if $scope.currentCategory.id then $scope.updateCategory() else $scope.createCategory()

  $scope.updateCategory = ->
    promise = $http
      method: 'put',
      url: '/api/categories/' + $scope.currentCategory.id + '.json',
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
      data: { category: $scope.currentCategory }
    promise.success (result,status,headers,config) ->
      console.log result
      if result.code == -1
        alert('失败')
      else
        $scope.categories = result.categories
      return
    promise.error (data,status,headers,config) ->
      console.log 'error'

  $scope.createCategory = ->
    promise = $http
      method: 'post',
      url: '/api/categories.json',
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
      data: {category: $scope.currentCategory}
    promise.success (result,status,headers,config) ->
      console.log result
      if result.code == -1
        alert('失败')
      else
        $scope.categories = result.categories
      return
    promise.error (data,status,headers,config) ->
      console.log 'error'
