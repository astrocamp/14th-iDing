class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :tel, null: false
      t.string :email
      t.integer :gender

      t.timestamps
    end
  end
end
