class CreateHolidays < ActiveRecord::Migration[7.0]
  def change
    create_table :holidays do |t|
      t.date :dayoff
      t.belongs_to :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
