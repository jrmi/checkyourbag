bagModule = angular.module('BagModule.controllers', [])

getUniqueId = () ->
     dateObject = new Date()
     idp = Math.floor(Math.random() * 1000000000)
     uniqueId =
          dateObject.getFullYear() + '' +
          dateObject.getMonth() + '' +
          dateObject.getDate() + '' +
          dateObject.getTime() + '' + idp

     return uniqueId

bagModule.controller 'BagCtrl', ['$scope', '$localStorage', '$routeParams', 'CategoryProvider',
    ($scope, $localStorage, $routeParams, CategoryProvider) ->
        $scope.$storage = $localStorage
        name = $routeParams.name
        $scope.$storage.current_bag = name
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
            
        $scope.toggle = (category, item) ->
            console.log item.checked
            if item.checked
                item.class = "checked"
                category.checked_items++
            else
                item.class = ""
                category.checked_items--
        
]

bagModule.controller 'BagTplCtrl', ['$scope', '$localStorage', '$routeParams', 'CategoryProvider',
    ($scope, $localStorage, $routeParams, CategoryProvider) ->
        $scope.$storage = $localStorage
        
        if not('tpl' of $scope.$storage)
            $scope.$storage.tpl = [
                id : 'default'
                name: 'Complet'
            ]
        console.log $scope.$storage
    
        $scope.newTpl = (tplname) ->
            if tplname
                $scope.$storage.tpl.push
                    id: getUniqueId()
                    name: tplname
                    
        $scope.deleteTpl = (idToRemove) ->
            $scope.$storage.tpl = (tpl for tpl in $scope.$storage.tpl when tpl.id isnt idToRemove)
                
            delete $scope.$storage["bag__#{idToRemove}"]

]