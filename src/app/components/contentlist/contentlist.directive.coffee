angular.module "door"
  .directive 'acmeContentlist', ->

    ContentlistController = ($scope, moment) ->

      $scope.myData =
        [
          {name: "Moroni",  age: 50},
          {name: "Tiancum", age: 43},
          {name: "Jacob",   age: 27},
          {name: "Nephi",   age: 29},
          {name: "Enos",    age: 34}
        ]
      $scope.gridOptions =
        data: 'myData'

      vm = this
      # "vm.creation" is avaible by directive option "bindToController: true"
      vm.relativeDate = moment(vm.creationDate).fromNow()
      return

    directive =
      restrict: 'AE'
      templateUrl: 'app/components/contentlist/contentlist.html'
      scope: creationDate: '='
      controller: ContentlistController
      controllerAs: 'vm'
      bindToController: true
