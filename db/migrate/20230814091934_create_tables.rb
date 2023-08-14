class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables do |t|
      t.string :name
      t.integer :seat_num
      t.string :status
      t.integer :category

      t.timestamps
    end
  end
end
