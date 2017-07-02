class CartContents
  attr_accessor :cart

  def initialize(cart)
    @cart = cart
  end

  def add(product_id, quantity)
    params = { cart_id: cart.id, product_id: product_id }
    cart_item = CartItem.find_by(params)
    cart_item ||= CartItem.create(params.merge(quantity: 0))

    cart_item.quantity += quantity
    cart_item.save!
    cart_item
  end
  
  def update(params)
    cart.update(params)
    cart.cart_items = cart.cart_items.select { |item| item.quantity.positive? }
  end
end
