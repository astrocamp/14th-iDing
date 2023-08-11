class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables do |t|
      t.string :name, null: false
      t.integer :seat, null: false
      t.string :status, default: "available"
      t.integer :category

      t.timestamps
    end
  end
end
