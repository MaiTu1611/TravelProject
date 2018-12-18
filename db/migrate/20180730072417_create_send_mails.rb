class CreateSendMails < ActiveRecord::Migration[5.1]
  def change
    create_table :send_mails do |t|
      t.string :mail_from
      t.string :mail_to
      t.string :type_mail
      t.string :attachment

      t.timestamps
    end
  end
end
