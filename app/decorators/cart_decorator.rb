class CartDecorator < ApplicationDecorator
  delegate_all

  def amount
    cart_items.map do |item|
      item.sub_total
    end.sum
  end

  def tax_amount
    (self.amount * 1.08).ceil
  end

  def tax
    tax_amount - amount
  end
end
