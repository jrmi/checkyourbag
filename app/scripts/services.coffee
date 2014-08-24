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
        cat.visible_items = cat.items.length
        for it in cat.items
            it.checked = false
            it.visible = true
    return data.categories

angular.module 'bagModule.services', []

.factory('CategoryProvider', ['$q', '$http', '$localStorage', '$translate',
    ($q, $http, $localStorage, $translate) ->
        # Load categories async
        $storage = $localStorage
    
        defaultbag_delay = $q.defer()
        
        data_file = 'data/' + $translate.use() + '.json'
        $http.get(data_file).success (data, status, headers, config) ->
            defaultbag_delay.resolve(loadcat(data))
        .error (data, status, headers, config) ->
            console.log "Fail to load data '" + data_file + "'. Using default."
            # Using default file            
            $http.get('/data/en.json').success (data, status, headers, config) ->
                defaultbag_delay.resolve(loadcat(data))
    
        return updatebag: (bagName) -> 
                delay = $q.defer()
        
                if !(bagName of $storage)
                    defaultbag_delay.promise.then (cat) ->
                        $storage[bagName] = cat
                        delay.resolve()    
                else
                    delay.resolve()
                
                return delay.promise
    
])