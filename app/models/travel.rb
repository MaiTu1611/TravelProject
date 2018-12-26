class Travel < ApplicationRecord
	# belongs_to :user
	has_many :tours, dependent: :destroy

		  # search
	 def self.search(search)
	    if search
	   	  	Travel.where("name_tour LIKE ?", "%#{search}%")
	    else
	      	Travel.all
	    end
	  end
end
