class CartController < ApplicationController
  def edit
    @cart = current_cart || Cart.incomplete.find_or_initialize_by(guest_token: cookies.signed[:guest_token],
                                                                  user_id: current_user.try!(:id))
    @cart = @cart.decorate
  end

  def cart_link
    render partial: 'shared/link_to_cart'
  end
end
