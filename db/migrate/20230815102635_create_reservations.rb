class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :restaurant_id
      t.string :customer_id
      t.date :date, null: false
      t.time :time, null: false
      t.integer :adult_num, null: false
      t.integer :kid_num, null: false, defult: 0
      t.string :purpose
      t.text :note
      t.string :serial

      t.timestamps
    end
  end
end
