class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts, comment: 'カート' do |t|
      t.references :user, foreign_key: true
      t.string :postal_code, default: "", comment: '郵便番号'
      t.string :address, default: "", comment: '住所'
      t.string :guest_token, comment: 'ゲストトークン'
      t.datetime :completed_at, comment: '取引完了日'

      t.timestamps
    end
  end
end
