class Tour < ApplicationRecord
	belongs_to :user
	belongs_to :travel
	before_create :default_values

	STATUS = %i[Chờ Duyệt Hủy]

	# Set default when user sign up
	def default_values
		self.status = 0
	end

	  # search
	  def self.search(search)
	    if search
	   	  	Tour.includes(:travel).where(travels: {name_tour: search})
	    else
	      	Tour.all
	    end
	  end
end
