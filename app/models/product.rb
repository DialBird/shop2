# == Schema Information
#
# Table name: products # 商品
#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null  # 商品名
#  price      :integer          default("0"), not null # 価格
#  cost       :integer          default("0"), not null # 原価
#  image      :string                                  # 商品画像
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cost, presence: true,
                   numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
