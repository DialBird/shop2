class ApplicationController < ActionController::Base
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
    setup_guest_token_if_necessary
    Cart.find_by(current_cart_params)
  end

  def current_cart_params
    # TODO: user_idの追加
    { guest_token: cookies.signed[:guest_token] }
  end

  def setup_guest_token_if_necessary
    return if cookies.signed[:guest_token].present?
    cookies.permanent.signed[:guest_token] = SecureRandom.urlsafe_base64
  end
end
