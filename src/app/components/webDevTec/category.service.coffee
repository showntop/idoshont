angular.module "door"
  .service "CategoryService", ($http) ->

    promise = $http
      method: 'get',
      url: '/api/categories/group.json',
      data: $scope.user
    promise.success (result,status,headers,config) ->
      console.log result
      if result.code == -1
        return 'error'
      else
        return result.category_group
    promise.error (data,status,headers,config) ->
      console.log 'error'

    return
