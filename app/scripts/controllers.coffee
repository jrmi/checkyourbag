
angular.module 'bagModule.controllers', []

.controller 'BagTplCtrl', ['$filter', '$scope', 'BagService', '$ionicActionSheet', '$translate',
  ($filter, $scope, BagService, $ionicActionSheet, $translate) ->

    $scope.bags = BagService.all()

    $scope.removeBag = BagService.remove

    $scope.newBag = (name) ->
      if name
        BagService.new(name)
        $scope.name = ""

    $scope.moveBag = BagService.move

    $scope.showActionSheet = (bag) ->
      hideSheet = $ionicActionSheet.show {
        buttons: [
          {text: $filter('translate')('btn-reset')},
        ],
        titleText: $filter('translate')('bag-action-title'),
        cancelText: $filter('translate')('btn-cancel'),
        cancel: () ->
          hideSheet()
        buttonClicked: (index) ->
          if index == 0
            BagService.reset(bag)
          return true
      }
]

.controller 'CatCtrl', ['$scope', '$stateParams', 'BagService', '$state', '$ionicViewSwitcher',
  ($scope, $stateParams, BagService, $state, $ionicViewSwitcher) ->
    $scope.catid = parseInt($stateParams.id, 10)
    $scope.bag = BagService.get($stateParams.bagId)
    $scope.category = $scope.bag.categories[$scope.catid]

    $scope.updateCounts = ()->
      BagService.updateCounts($scope.bag)

    $scope.removeItem = (index) ->
      $scope.category.items.splice(index, 1)
      BagService.updateCounts($scope.bag)

    $scope.newItem = (name) ->
      if name
        $scope.category.items.push
          label: name
          checked: false
          visible: true
        BagService.updateCounts($scope.bag)

    $scope.moveItem = (item, fromIndex, toIndex) ->
      $scope.category.items.splice(fromIndex, 1)
      $scope.category.items.splice(toIndex, 0, item)

    $scope.nextCategory = () ->
      if $scope.catid >= $scope.bag.categories.length - 1
        $scope.catid = $scope.bag.categories.length - 1
      else
        $ionicViewSwitcher.nextDirection('forward')
        $state.go('bag.category', {'bagId': $scope.bag.id, id: $scope.catid + 1})

    $scope.previousCategory = () ->
      if $scope.catid <= 0
        $scope.catid = 0
      else
        $ionicViewSwitcher.nextDirection('back')
        $state.go('bag.category', {'bagId': $scope.bag.id, id: $scope.catid - 1})

]
