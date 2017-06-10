# == Schema Information
#
# Table name: carts # カート
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  postal_code  :string           default("")           # 郵便番号
#  address      :string           default("")           # 住所
#  guest_token  :string                                 # ゲストトークン
#  completed_at :datetime                               # 取引完了日
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :cart do
    user nil
    postal_code '1234567'
    address 'address'
  end
end
