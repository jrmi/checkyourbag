bagModule = angular.module('BagModule', ['ngRoute', 'ui.bootstrap', 'BagModule.controllers', 'BagModule.services'])

bagModule.config ['$routeProvider',
    ($routeProvider) ->
        $routeProvider.when '/',
            controller: 'BagCtrl'
            templateUrl: 'views/bag.html'
        .when '/menu',
            controller: 'MenuCtrl'
            templateUrl: 'views/menu.html'
        .otherwise redirectTo: '/'
]
