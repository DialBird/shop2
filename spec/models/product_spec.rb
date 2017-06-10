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

require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
