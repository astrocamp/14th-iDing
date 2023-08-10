class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :tel, null: false
      t.string :email
      t.date :date, null: false
      t.time :time, null: false
      t.string :purpose
      t.string :note

      t.timestamps
    end
  end
end
