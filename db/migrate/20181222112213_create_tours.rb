class CreateTours < ActiveRecord::Migration[5.1]
  def change
    create_table :tours do |t|
      t.integer :user_id
      t.integer :travel_id

      t.timestamps
    end
  end
end
