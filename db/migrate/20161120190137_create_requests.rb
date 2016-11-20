class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.integer :allotment_id
      t.string :length
      t.string :type

      t.timestamps

    end
  end
end
