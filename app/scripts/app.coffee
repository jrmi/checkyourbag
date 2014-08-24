angular.module('Ionicyo', ['ionic', 'Ionicyo.services', 'Ionicyo.controllers', 'ngStorage'])

.config ($stateProvider, $urlRouterProvider) ->

  $stateProvider

    .state 'bag', 
      url: '/bag',
      abstract: true,
      templateUrl: 'templates/main.html'
            
    .state 'bag.list', 
      url: '/all',
      views:
        'bag': 
          templateUrl: 'templates/bagtpl.html',
          controller: 'BagTplCtrl'
            
    .state 'bag.listedit', 
      url: '/list_edit',
      views:
        'bag': 
          templateUrl: 'templates/bagtpl_edit.html',
          controller: 'BagTplCtrl'
            
    .state 'bag.content', 
      url: '/:name',
      views:
        'bag': 
          templateUrl: 'templates/bag.html',
          controller: 'BagCtrl'  
            
    .state 'bag.edit', 
      url: '/edit/:name',
      views:
        'bag': 
          templateUrl: 'templates/bagedit.html',
          controller: 'BagCtrl' 
              
    .state 'bag.category', 
      url: '/details/:name/cat/:id',
      views:
        'bag': 
          templateUrl: 'templates/category.html',
          controller: 'CatCtrl'
            
    .state 'bag.category_edit', 
      url: '/details_edit/:name/cat/:id',
      views:
        'bag': 
          templateUrl: 'templates/categoryedit.html',
          controller: 'CatCtrl'
            
    

  $urlRouterProvider.otherwise '/bag/all'


