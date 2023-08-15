class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :english_name, null: false
      t.string :tel, null: false
      t.string :address, null: false
      t.text :description
      t.string :UBN
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
