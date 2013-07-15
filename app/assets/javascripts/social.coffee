$ ->
  setTimeout ->
    $('#social .row').hide()

    $('#social .row:first').fadeIn 1000, ->
      $('#social .row:last').fadeIn(1000)

  , 700
