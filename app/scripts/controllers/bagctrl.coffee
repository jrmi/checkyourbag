bagModule = angular.module('BagModule.controllers', [])

bagModule.controller('BagCtrl', ['$scope', 'CategoryProvider' 
    ($scope, CategoryProvider) ->
        
        CategoryProvider.then (categories)->
            $scope.categories = categories

        $scope.toggle = (category, item) ->
            if item.checked
                item.checked = false
                item.class = ""
                category.checked_items--
            else
                item.checked = true
                item.class = "checked"
                category.checked_items++
        
]);