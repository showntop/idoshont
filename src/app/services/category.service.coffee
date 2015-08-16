angular.module('door')
  .factory('categoryService',['$http', '$q', ($http, $q) ->

    categoryService =
      list: []

    categoryService.loadList = ->
      if this.list.length > 0 then this.list else ->
      deferred = $q.defer()
      $http(
        method: 'get'
        url: '/api/categories.json')
        .success (data) ->
          categoryService.list = data.categories
          deferred.resolve data.categories
        .error ->
          deferred.reject('there was an error')

    categoryService.updateCategory = (category) ->
      promise = $http
        method: 'put',
        url: '/api/categories/' + category.id + '.json',
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
        data: {category: category}
      promise.success (result,status,headers,config) ->
        console.log result
        if result.code == -1
          alert('失败')
        else

        return
      promise.error (data,status,headers,config) ->
        console.log 'error'

    categoryService.createCategory = (category) ->
      promise = $http
        method: 'post',
        url: '/api/categories.json',
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
        data: {category: category}
      promise.success (result,status,headers,config) ->
        console.log result
        if result.code == -1
          alert('失败')
        else

        return
      promise.error (data,status,headers,config) ->
        console.log 'error'

    return categoryService
  ])