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

FactoryGirl.define do
  factory :cart_item do
    product nil
    cart nil
    quantity 1
  end
end
