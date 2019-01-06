class Travel < ApplicationRecord
	# belongs_to :user
	has_many :tours, dependent: :destroy
  validates :name_tour, presence: true
  validates :price, presence: true
  validates :date, presence: true
  validates :time_go, presence: true
  validates :details, presence: true

		  # search
	 def self.search(search)
	    if search
	   	  	Travel.where("name_tour LIKE ?", "%#{search}%")
	    else
	      	Travel.all
	    end
	  end
end
