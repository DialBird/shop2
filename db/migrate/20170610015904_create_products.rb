class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products, comment: '商品' do |t|
      t.string :name, default: "", null: false, comment: '商品名'
      t.integer :price, default: 0, null: false, comment: '価格'
      t.integer :cost, default: 0, null: false, comment: '原価'
      t.string :image, comment: '商品画像'

      t.timestamps
    end
  end
end
