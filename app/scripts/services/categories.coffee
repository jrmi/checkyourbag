bagModule = angular.module('BagModule.services', [])

getUniqueId = () ->
     dateObject = new Date()
     idp = Math.floor(Math.random() * 1000000000)
     uniqueId =
          dateObject.getFullYear() + '' +
          dateObject.getMonth() + '' +
          dateObject.getDate() + '' +
          dateObject.getTime() + '' + idp

     return uniqueId
        
loadcat = (data) ->
    for cat in data.categories
        cat.uid = getUniqueId()
        cat.checked_items = 0
    return data.categories

bagModule.factory('CategoryProvider', ['$q', '$http', 
    ($q, $http) ->
        # Load categories async
        delay = $q.defer()
        
        document.webL10n.ready ->
            data_file = 'data/' + document.webL10n.getLanguage() + '.json'
            $http.get(data_file).success (data, status, headers, config) ->
                delay.resolve(loadcat(data))
            .error (data, status, headers, config) ->
                console.log "Fail to load data '" + data_file + "'. Using default."
                # Using default file            
                $http.get('/data/en.json').success (data, status, headers, config) ->
                    delay.resolve(loadcat(data))
    
        return delay.promise
    
])