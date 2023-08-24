class Droptablename < ActiveRecord::Migration[7.0]
  def change
    drop_table :customers
  end
end
