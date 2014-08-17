template = $('#template').html()

Mustache.parse template

$ ->
    document.webL10n.ready ->
        data_file = 'data/' + document.webL10n.getLanguage() + '.json'
        $.getJSON data_file, (data) ->
            rendered = Mustache.render template, data
            $('#items').html(rendered)
            $(".item").click ->
                $(this).toggleClass('check')
                $(this).toggleClass('text-success')
