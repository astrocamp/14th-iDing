class RemoveColumnFromCustomer < ActiveRecord::Migration[7.0]
  def change
    remove_column :customers, :date, :date
    remove_column :customers, :time, :time
    remove_column :customers, :purpose, :string
    remove_column :customers, :note, :string
    add_column :customers, :gender, :integer
  end
end
