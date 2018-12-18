class Article < ApplicationRecord

	mount_uploader :image, ImageUploader
	validates :image, file_size: { less_than: 1.megabytes }
	# validates :file, file_size: { less_than: 1.megabytes }
	validates :title, presence: true
  validates :post, presence: true

    def self.search(search)
	  if search
	  	Article.where(
	  		'(title = ?) OR 
	  		(post = ?)',
	  		search, search)
	  else
	    Article.all
	  end
	end
end
