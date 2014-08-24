angular.module('bagModule', ['ionic', 'bagModule.services', 'bagModule.controllers', 'ngStorage', 'pascalprecht.translate'])

.config ['$stateProvider', '$urlRouterProvider', '$compileProvider', '$translateProvider', ($stateProvider, $urlRouterProvider, $compileProvider, $translateProvider) ->
    
  $compileProvider.aHrefSanitizationWhitelist /^\s*(app|https?|ftp|mailto|chrome-extension):/
    
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
    
       
  $translateProvider
  .translations 'en',
    'btn-edit': 'Edit'
    'btn-add': 'Add'
    'btn-done': 'Done'
    'btn-reset': 'Reset'
    'btn-reset-all': 'Reset all'
    'btn-remove': 'Remove'
    'btn-reorder': 'Reorder'
    'edit-your-bags': 'Edit your bags'
    'choose-your-category': 'Choose your category'
    'choose-your-bag': 'Choose Your Bag'
    'choose-visible': 'Choose visible items'
    'item-name': 'Item name'
    'bag-name': 'Bag name'
    'full-bag': 'Start bag'
    
  .translations 'fr',
    'btn-edit': 'Modifier'
    'btn-add': 'Ajouter'
    'btn-done': 'Fin'
    'btn-reset': 'Recommencer'
    'btn-reset-all': 'Réinitialiser tout'
    'btn-remove': 'Supprimer'
    'btn-reorder': 'Réordonner'
    'edit-your-bags': 'Modification'
    'choose-your-category': 'Quelle categorie ?'
    'choose-your-bag': 'Quel sac ?'
    'choose-visible': 'Modification'
    'item-name': 'Nom'
    'bag-name': 'Nom du sac'
    'full-bag': 'Sac complet'
  
  .registerAvailableLanguageKeys ['en', 'fr'],
    'en_US': 'en'
    'en_UK': 'en'
    'fr_FR': 'fr'
    'fr_BE': 'fr'
    
  .fallbackLanguage('en');
    
  $translateProvider.determinePreferredLanguage()
]
