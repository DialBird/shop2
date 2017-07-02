$ ->
  $('form#update_cart button.delete').on 'click', (e) ->
    e.preventDefault
    $(this).closest('.cart_item').find('input.cart_item_quantity').val 0
    $(this).closest('form').submit()

  $('form#update_cart').on 'submit', ->
    $(this).find('button.delete').prop('disabled', true)
