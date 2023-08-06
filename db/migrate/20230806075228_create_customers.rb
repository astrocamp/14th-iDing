class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :tel
      t.string :email
      t.date :date
      t.time :time
      t.string :purpose
      t.string :note

      t.timestamps
    end
  end
end
