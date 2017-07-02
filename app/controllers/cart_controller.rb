class CartController < ApplicationController
  def edit
    @cart = current_cart || Cart.incomplete.find_or_initialize_by(guest_token: cookies.signed[:guest_token],
                                                                  user_id: current_user.try!(:id))
    @cart = @cart.decorate
  end

  def cart_link
    render partial: 'shared/link_to_cart'
  end

  def populate
    @cart = current_cart(create_cart_if_necessary: true)
    quantity = params[:quantity].to_i
    product_id = params[:product_id].to_i
    @cart.contents.add(product_id, quantity)

  rescue ActiveRecord::RecordInvalid => e
    @cart.errors.add(:base, e.record.errors.full_messages.join(','))
  ensure
    if @cart.errors.any?
      flash[:error] = @cart.errors.full_messages.join(',')
      redirect_back(fallback_location: root_path)
    else
      redirect_to cart_path
    end
  end
end
