class AdminController < ApplicationController
	def manage_users
  	end

  	def edit_user_details
    	@user = User.find(params[:id])
  	end
end
