# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.ShopGokko = {}

ShopGokko.fetch_cart = (url) ->
  $.ajax url,
    type: 'GET'
    dataType: 'html'
    error: (e) ->
      console.log e
    success: (data) ->
      $('#link-to-cart').html data
