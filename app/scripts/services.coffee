

getUniqueId = () ->
  dateObject = new Date()
  idp = Math.floor(Math.random() * 1000000000)
  uniqueId =
    dateObject.getFullYear() + '' +
      dateObject.getMonth() + '' +
      dateObject.getDate() + '' +
      dateObject.getTime() + '' + idp

  return uniqueId

angular.module 'bagModule.services', []
.factory 'BagService', ['$q', '$http', '$localStorage', '$translate',
  ($q, $http, $localStorage, $translate) ->

    service = {
    get: (bagId) ->
      for bag in $localStorage.bags
        if bag.id == bagId
          return bag
      return null

    reset: (bag) ->
      for cat in bag.categories
        for item in cat.items
            item.checked = false
      @updateCounts(bag)

    updateCounts: (bag) ->
      bag.checked_items = 0
      bag.visible_items = 0

      for cat in bag.categories
        @updateCategoryCounts(cat)
        bag.checked_items += cat.checked_items
        bag.visible_items += cat.visible_items

    updateCategoryCounts: (category) ->
      category.checked_items = 0
      category.visible_items = 0
      for item in category.items
          if item.visible
              category.visible_items++
              if item.checked
                  category.checked_items++

    move: (bag, fromIndex, toIndex) ->
      $localStorage.bags.splice(fromIndex, 1)
      $localStorage.bags.splice(toIndex, 0, bag)

    moveCategoryItem: (category, item, fromIndex, toIndex) ->
      category.splice(fromIndex, 1)
      category.splice(toIndex, 0, item)

    removeCategoryItem: (category, index) ->
      category.items.splice(index, 1)

    all: () ->
      return $localStorage.bags

    new: (name) ->
      newBag = {}
      newBag.id = getUniqueId()
      newBag.name = name
      newBag.categories = []
      $localStorage.bags.push(newBag)

      @getDefaultCategories().then (categories) =>
        newBag.categories = angular.copy(categories)
        service.updateCounts(newBag)

      return newBag

    remove: (index) ->
      $localStorage.bags.splice(index, 1)

    _loadcat: (data) ->
      for cat in data.categories
        cat.uid = getUniqueId()
        cat.checked_items = 0
        cat.visible_items = cat.items.length
        for it in cat.items
          it.checked = false
          it.visible = true
      return data.categories

    getDefaultCategories: () ->
      defaultbagDefer = $q.defer()

      data_file = 'data/' + $translate.use() + '.json'

      $http.get(data_file)
      .success (data, status, headers, config) =>
        defaultbagDefer.resolve(@_loadcat(data))

      .error (data, status, headers, config) =>
        console.log "Fail to load data '" + data_file + "'. Using default."
        # Using default file
        $http.get('/data/en.json').success (data, status, headers, config) =>
          defaultbagDefer.resolve(@_loadcat(data))

      return defaultbagDefer.promise

    }

    if not $localStorage.bags?

      $localStorage.bags = []
      $translate('full-bag').then (translation) ->
        service.new(translation)

    return service
]