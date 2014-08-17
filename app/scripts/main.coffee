template = $('#template').html()

Mustache.parse template

getUniqueId = () ->
     dateObject = new Date();
     idp = Math.floor(Math.random() * 1000000000);
     uniqueId =
          dateObject.getFullYear() + '' +
          dateObject.getMonth() + '' +
          dateObject.getDate() + '' +
          dateObject.getTime() + '' + idp

     return uniqueId

loaddata = (data_file) -> 
        return $.getJSON data_file, (data) ->
            
            for category in data.categories
                category.uid = getUniqueId()
                console.log category.uid

            rendered = Mustache.render template, data
            $('#items').html(rendered)
            $(".item").click ->
                $(this).toggleClass('check')
                $(this).toggleClass('text-success')

$ ->
    document.webL10n.ready ->
        data_file = 'data/' + document.webL10n.getLanguage() + '.json'
        loaddata(data_file).error ->
            console.log "Fail to load data '" + data_file + "'. Using default."
            # Using default file
            loaddata('data/en.json')
            
