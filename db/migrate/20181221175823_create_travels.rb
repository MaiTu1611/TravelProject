class CreateTravels < ActiveRecord::Migration[5.1]
  def change
    create_table :travels do |t|
      t.string :name_tour
      t.integer :price
      t.integer :date
      t.time :time_go

      t.timestamps
    end
  end
end
