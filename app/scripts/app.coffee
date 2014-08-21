bagModule = angular.module('BagModule', ["mobile-angular-ui", 'BagModule.controllers', 'BagModule.services', 'ngStorage', 'ngRoute'])

bagModule.config ['$routeProvider',
    ($routeProvider) ->
        '''if not 'current_bag' of $localStorage
            $localStorage.current_bag = 'default'
            
        console.log $localStorage'''
            
        $routeProvider.when '/bag/:name',
            controller: 'BagCtrl'
            templateUrl: 'views/bag.html'
        $routeProvider.when '/bagedit/:name',
            controller: 'BagCtrl'
            templateUrl: 'views/bagedit.html'
        .when '/menu',
            controller: 'MenuCtrl'
            templateUrl: 'views/menu.html'
        .otherwise redirectTo: '/bag/default'
]
