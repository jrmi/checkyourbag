
angular.module 'bagModule.controllers', []

.controller 'BagTplCtrl', ['$scope', '$localStorage', 'BagService', '$state', '$translate',
  ($scope, $localStorage, BagService, $state, $translate) ->
    $scope.$storage = $localStorage

    $scope.bags = BagService.all()

    $scope.resetBag = BagService.reset

    $scope.removeBag = BagService.remove

    $scope.newBag = (name) ->
      BagService.new(name)
      $scope.name = ""

    $scope.moveBag = BagService.move
]

.controller 'CatCtrl', ['$scope', '$localStorage', '$stateParams', 'BagService', '$state', '$ionicViewSwitcher',
  ($scope, $localStorage, $stateParams, BagService, $state, $ionicViewSwitcher) ->
    $scope.$storage = $localStorage
    $scope.catid = parseInt($stateParams.id, 10)
    $scope.bag = BagService.get($stateParams.bagId)
    $scope.category = $scope.bag.categories[$scope.catid]

    $scope.updateCounts = ()->
      BagService.updateCounts($scope.bag)

    $scope.removeItem = (index) ->
      $scope.category.items.splice(index, 1)
      BagService.updateCounts($scope.bag)

    $scope.newItem = (name) ->
      $scope.category.items.push
        label: name
        checked: false
        visible: true
      BagService.updateCounts($scope.bag)

    $scope.moveItem = (item, fromIndex, toIndex) ->
      $scope.category.splice(fromIndex, 1)
      $scope.category.splice(toIndex, 0, item)

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
