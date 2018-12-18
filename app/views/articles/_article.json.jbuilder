json.extract! article, :id, :title, :post, :created_at, :updated_at
json.url article_url(article, format: :json)
