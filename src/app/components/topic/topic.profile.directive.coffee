angular.module "door"
  .directive 'topicProfile', ->

    ProfileController = ($scope) ->
      $scope.topic =
        title: '中华文明上下五千年'
        cooked: '<p>积分拉斯肯德基法拉盛看风景<br><strong>积分卢卡斯减肥了贷款萨芬</strong><br><em>解放东路撒酒疯卡萨浪费</em></p>

              <blockquote><p>开发链接萨克拉地方<br><a href="http://fjks.com">积分卢卡斯剪短发了凯撒</a></p></blockquote>

              <hr>

              <p>fjdaslkfj <img src="/images/emoji/emoji_one/grimacing.png?v=0" title=":grimacing:" class="emoji" alt="grimacing"><img src="/uploads/default/original/1X/1f9cb60bb5a1711014d35223a7bac99e0e042330.png" width="128" height="128"></p>'

    directive =
      restrict: 'AE'
      templateUrl: 'app/components/topic/topic.profile.html'
      scope: topic: '='
      controller: ProfileController
      link: (scope, element, attrs) ->
        element.innerHtml = $scope.cooked
