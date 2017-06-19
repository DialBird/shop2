class ApplicationController < ActionController::Base
  include Auth

  protect_from_forgery with: :exception

  helper_method :current_cart

  def current_cart(options = {})
    options[:create_cart_if_necessary] ||= false

    return @current_cart if @current_cart

    @current_cart = find_cart_by_token_or_user

    if @current_cart.blank? and options[:create_cart_if_necessary]
      @current_cart = Cart.create(current_cart_params)
    end

    @current_cart
  end

  private

  def find_cart_by_token_or_user
    Cart.find_by(current_cart_params)
  end

  def current_cart_params
    { guest_token: cookies.signed[:guest_token],
      user_id: current_user.try!(:id) }
  end
end
