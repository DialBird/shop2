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

class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  accepts_nested_attributes_for :cart_items, allow_destroy: true, reject_if: :all_blank

  validates :guest_token, presence: true
  validates :postal_code, format: { with: /\A\d{7}\z/, allow_blank: true }

  scope :incomplete, -> {
    where(completed_at: nil)
  }

  def any_items?
    0 < cart_items.size
  end
end
