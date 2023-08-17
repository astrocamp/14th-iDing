class CreateOpenTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :open_times do |t|
      t.time :opening_time
      t.time :closed_time
      t.belongs_to :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
