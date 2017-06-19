module CartHelper
  def link_to_cart
    text = if current_cart.present? and current_cart.any_items?
             "Cart: (選択中の商品：#{current_cart.cart_items.count}種類)"
           else
             "Cart: (Empty)"
           end
    link_to text.html_safe, cart_path
  end
end
