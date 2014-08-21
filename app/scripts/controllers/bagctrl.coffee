bagModule = angular.module('BagModule.controllers', [])

bagModule.controller('BagCtrl', ['$scope', '$localStorage', '$routeParams', 'CategoryProvider',
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
        
]);