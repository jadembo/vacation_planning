class CreateAllotments < ActiveRecord::Migration
  def change
    create_table :allotments do |t|
      t.date :date
      t.integer :days_available
      t.integer :role_id
      t.integer :department_id

      t.timestamps

    end
  end
end
