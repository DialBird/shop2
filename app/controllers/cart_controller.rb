class CartController < ApplicationController
  def edit
  end

  def cart_link
    render partial: 'shared/link_to_cart'
  end
end
