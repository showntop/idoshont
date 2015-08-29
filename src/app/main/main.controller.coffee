angular.module "door"
  .controller "MainController", ($scope, categoryService, topicService) ->
    $scope.role1Categories = [
      {name: '随笔', background: '/assets/images/clouds1.png'},
      {name: '长篇', background: '/assets/images/clouds2.png'},
      {name: '畅想', background: '/assets/images/clouds3.png'},
      {name: '艺术', background: '/assets/images/clouds4.png'},
      {name: '情怀', background: '/assets/images/clouds1.png'}
    ]

    $scope.role2Categories = [
      {name: '吐槽', background: '/assets/images/note1.svg'},
      {name: '段子', background: '/assets/images/note2.svg'},
      {name: '意淫', background: '/assets/images/note3.svg'},
      {name: '购买', background: '/assets/images/note4.svg'},
      {name: '再来一杯', background: '/assets/images/note1.svg'}
    ]

    promise = topicService.loadTopList()
    # 同步调用，获得承诺接口
    promise.then ((data) ->
      # 调用承诺API获取数据 .resolve
      $scope.topTopics = data.topics
      return
    ), (data) ->
      # 处理错误 .reject
      $scope.user = error: '用户不存在！'
      return

    return
