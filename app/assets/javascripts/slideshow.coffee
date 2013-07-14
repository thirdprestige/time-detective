$(document).ready ->
  # I don't know why we need a setTimeout
  # but whatever
  setTimeout ->
    $('.panel').hide().
      first().show()

    $('.arrow').click ->
      return if $('.panel').is(':animated')

      panel = $('.panel:visible')

      return if $(@).hasClass('left')  unless panel.prev('.panel').length > 0
      return if $(@).hasClass('right') unless panel.next('.panel').length > 0

      panel.fadeOut =>
        if $(@).hasClass('left')
          panel.prev().fadeIn()
        else
          panel.next().fadeIn()

  , 700
