angular.module('door')
  .factory('topicService',['$http', '$q', ($http, $q) ->

    topicService =
      toplist: []

    topicService.loadTopList = () ->
      deferred = $q.defer()
      promise = $http
        method: 'get',
        url: '/api/topics.json',
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
      promise.success (result,status,headers,config) ->
        console.log result
        if result.code == -1
          alert('失败')
        else
          this.toplist = result.topics
          deferred.resolve(result)
      promise.error (result,status,headers,config) ->
        deferred.reject(result)

      return deferred.promise


    topicService.update = (topic) ->
      promise = $http
        method: 'put',
        url: '/api/topics/' + topic.id + '.json',
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

    topicService.create = (topic) ->
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

    topicService.upload = (attachment) ->
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

    return topicService
  ])