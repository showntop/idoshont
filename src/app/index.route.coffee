angular.module "door"
  .config ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state "main",
        url: "/"
        templateUrl: "app/main/main.html"
        controller: "MainController"
        controllerAs: "main"
      .state "login",
        url: "/login"
        templateUrl: "app/components/user/user.login.html"
        controller: "UserController"
      .state "profile",
        url: "/profile"
        templateUrl: "app/components/user/user.profile.html"
        controller: "UserController"
      .state "category",
        #abstract: true
        url: "/category"
        templateUrl: "app/components/category/index.html"
        controller: "CategoryListController"
      .state "categorynav",
        url: "/categorynav"
        templateUrl: 'app/components/category/nav.html'
        controller: "CategoryController"
      .state "topic",
        url: "/topic"
        templateUrl: "app/components/topic/topic.new.html"
        controller: "TopicController"

#     .state "category.list",
#        url: ''
#        templateUrl: 'app/modules/category/index.html'
#      .state "category.detail",
#        url: "/:id"
#        templateUrl: "app/modules/category/detail.html"
#        controller: "CategoryController"
      # .state "category.basic",
      #   views:
      #     'category@category.basic':
      #       templateUrl: 'app/modules/category/partials/basic.html'
      #       controller: ->
      #         console.log 'xxxxxxxxxxxxxxxx'
      # .state "category.safe",
      #   views:
      #     'category@category.basic':
      #       templateUrl: 'app/modules/category/partials/basic.html'
      #       controller: ->
      #         console.log 'xxxxxxxxxxxxxxxx'
      # .state "category.style",
      #   views:
      #     'category@category.basic':
      #       templateUrl: 'app/modules/category/partials/basic.html'
      #       controller: ->
      #         console.log 'xxxxxxxxxxxxxxxx'

    .state "demo",
        url: "/demos/{path}"
        templateUrl: ($stateParams) ->
          console.log($stateParams)
          return '/app/demos/' + $stateParams.path + '/demo.html'

    $urlRouterProvider.otherwise '/'
