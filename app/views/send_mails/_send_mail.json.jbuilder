json.extract! send_mail, :id, :mail_from, :mail_to, :type_mail, :attachment, :created_at, :updated_at
json.url send_mail_url(send_mail, format: :json)
