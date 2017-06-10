class CreateCartItems < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_items, comment: 'カート商品' do |t|
      t.references :product, foreign_key: true
      t.references :cart, foreign_key: true
      t.integer :quantity, default: 0, null: false, comment: '量'

      t.timestamps
    end
  end
end
