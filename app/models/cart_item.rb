# == Schema Information
#
# Table name: cart_items # カート商品
#
#  id         :integer          not null, primary key
#  product_id :integer
#  cart_id    :integer
#  quantity   :integer          default("0"), not null # 量
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CartItem < ApplicationRecord
  PERMITTED_ATTRIBUTES = %i(id quantity).freeze

  belongs_to :product
  belongs_to :cart

  validates :quantity, presence: true,
                       numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def sub_total
    product.price * quantity
  end
end
