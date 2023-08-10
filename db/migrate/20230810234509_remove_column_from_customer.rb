class RemoveColumnFromCustomer < ActiveRecord::Migration[7.0]
  def change
    remove_column :customers, :date
    remove_column :customers, :time
    remove_column :customers, :purpose
    remove_column :customers, :note
  end
end
