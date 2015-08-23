angular.module "door"
  .directive 'acmeNavbar', ->

    NavbarController = ($scope, ngDialog) ->
      $scope.dirs = [
        "accordion", "carousel", "dropdown", "popover", "tabs", "typeahead",
        "alert", "collapse", "modal", "progressbar", "timepicker", "buttons",
        "datepicker", "pagination", "rating", "tooltip"
      ]
      $scope.isCollapsed = true
      vm = this
      # "vm.creation" is avaible by directive option "bindToController: true"
      #vm.relativeDate = moment(vm.creationDate).fromNow()

      $scope.newTopic = ->
        ngDialog.open
          template: 'app/components/topic/topic.new.html'
          appendTo: '#main-container'
          closeByDocument: false
          name: 'newTopic'
          scope: $scope
          overlay: false
          controller: 'TopicController'
          className: 'ngdialog-theme-topic'
      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/navbar/navbar.html'
      scope: creationDate: '='
      controller: NavbarController
      controllerAs: 'vm'
      bindToController: true
