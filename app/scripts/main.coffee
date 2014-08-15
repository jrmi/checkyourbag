template = $('#template').html()

Mustache.parse template

$ ->
    $.getJSON '/data/fr.json', (data) ->
        rendered = Mustache.render template, data
        $('#items').html(rendered)
        $(".item").click ->
            $(this).toggleClass('check')
            $(this).toggleClass('text-success')
