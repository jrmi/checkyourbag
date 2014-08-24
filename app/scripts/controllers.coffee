getUniqueId = () ->
     dateObject = new Date()
     idp = Math.floor(Math.random() * 1000000000)
     uniqueId =
          dateObject.getFullYear() + '' +
          dateObject.getMonth() + '' +
          dateObject.getDate() + '' +
          dateObject.getTime() + '' + idp

     return uniqueId

angular.module 'bagModule.controllers', []

.controller 'BagTplCtrl', ['$scope', '$localStorage', 'CategoryProvider', '$state', '$translate',
    ($scope, $localStorage, CategoryProvider, $state, $translate) ->
        $scope.$storage = $localStorage
        
        if not('tpl' of $scope.$storage)
            $translate('full-bag').then (fullBagName) ->
                $scope.$storage.tpl = [
                    id : 'default'
                    name: fullBagName
                ]
    
        $scope.newTpl = (name) ->
            if name
                found = false
                for bag in $scope.$storage.tpl
                    if name == bag.name
                        found = true
                if !found
                    $scope.$storage.tpl.push
                        id: getUniqueId()
                        name: name
            
        $scope.moveBag = (item, fromIndex, toIndex) ->
            $scope.$storage.tpl.splice(fromIndex, 1)
            $scope.$storage.tpl.splice(toIndex, 0, item)
                    

]

.controller 'BagCtrl', ['$scope', '$localStorage', '$stateParams', 'CategoryProvider',
    ($scope, $localStorage, $stateParams, CategoryProvider) ->
        $scope.$storage = $localStorage
        $scope.current_bag = $stateParams.name
        $scope.bagName = "bag__#{name}"
        
        CategoryProvider.updatebag($scope.bagName)

        $scope.resetBag = () ->
            for cat in $scope.$storage[$scope.bagName]
                for item in cat.items
                    item.checked = false
                $scope.updateCounts(cat)
        
        $scope.updateCounts = (cat) ->
            cat.checked_items = 0
            cat.visible_items = 0
            for item in cat.items
                if item.visible
                    cat.visible_items++
                    if item.checked
                        cat.checked_items++
        
]

.controller 'CatCtrl', ['$scope', '$localStorage', '$stateParams', 'CategoryProvider',
    ($scope, $localStorage, $stateParams, CategoryProvider) ->
    
        $scope.$storage = $localStorage
        $scope.current_bag = $stateParams.name
        $scope.catid = $stateParams.id
        $scope.bagName = "bag__#{name}"
        
        CategoryProvider.updatebag($scope.bagName)
        
        $scope.updateCounts = (bagName, catid) ->
            cat = $scope.$storage[bagName][catid]
            cat.checked_items = 0
            cat.visible_items = 0
            for item in cat.items
                if item.visible
                    cat.visible_items++
                    if item.checked
                        cat.checked_items++
            
        $scope.newItem = (bagName, catid, name) ->
            if name
                found = false
                for item in $scope.$storage[bagName][catid].items
                    if name == item.label
                        found = true
                if !found
                   $scope.$storage[bagName][catid].items.push
                        label: name
                        checked: false
                        visible: true
                        
        $scope.moveItem = (bagName, catid, item, fromIndex, toIndex) ->
            $scope.$storage[bagName][catid].items.splice(fromIndex, 1)
            $scope.$storage[bagName][catid].items.splice(toIndex, 0, item)
        
]

  
