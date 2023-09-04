class AddPositionxyToTable < ActiveRecord::Migration[7.0]
  def change
    add_column :tables, :site_x, :integer, default: 1
    add_column :tables, :site_y, :integer, default: 1
  end
end
