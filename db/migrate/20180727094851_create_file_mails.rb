class CreateFileMails < ActiveRecord::Migration[5.1]
  def change
    create_table :file_mails do |t|
      t.string :file_name
      t.integer :user_id

      t.timestamps
    end
  end
end
