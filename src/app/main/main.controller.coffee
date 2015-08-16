angular.module "door"
  .controller "MainController", ($scope, categoryService) ->
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

    categoryService.loadList()

    return
