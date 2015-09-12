angular.module('door')
  .factory('userService',['$http', '$q', ($http, $q) ->

    userService =
      user: {}      

    userService.login = (login, password) ->
      deferred = $q.defer()
      promise = $http
        method: 'post',
        url: '/api/users/signin.json',
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
        data: {login: login, password: password}
      promise.success (result,status,headers,config) ->
        console.log result
        this.user = result.user
        deferred.resolve(result)
      promise.error (result,status,headers,config) ->
        deferred.reject(result)
      return deferred.promise

    userService.registe = (user) ->
      deferred = $q.defer()
      promise = $http
        method: 'post',
        url: '/api/users/signup.json'
        data: {user: user}
      promise.success (result, status, headers, config) ->
        console.log '注册成功'
        console.log result
        this.user = result.user
        deferred.resolve result
      promise.error (result, status, headers, config) ->
        deferred.reject(result)
      return deferred.promise

    userService.update = (userPorfile) ->
      promise = $http
        method: 'put',
        url: '/api/users.json',
        headers: {
          'token': $('').attr('content')
        }
        data: {user_profile: userPorfile}
      promise.success (result,status,headers,config) ->
        console.log result
        if result.code == -1
          alert('失败')
        else

        return
      promise.error (data,status,headers,config) ->
        console.log 'error'

    userService.create = (topic) ->
      promise = $http
        method: 'post',
        url: '/api/topics.json',
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
        data: {topic: topic}
      promise.success (result,status,headers,config) ->
        console.log result
        if result.code == -1
          alert('失败')
        else

        return
      promise.error (data,status,headers,config) ->
        console.log 'error'

    userService.upload = (attachment) ->
      promise = $http
        method: 'post',
        url: '/api/topic_attachments.json',
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
        data: {topic_attachment: attachment}
      promise.success (result,status,headers,config) ->
        console.log result
        if result.code == -1
          alert('失败')
        else

        return
      promise.error (data,status,headers,config) ->
        console.log 'error'

    return userService
  ])