class WelcomeController < ApplicationController
  	def index
  		if !params[:search].blank?
  			@travels = Travel.search(params[:search])
	    else
	      	@travels = Travel.all
	    end
  	end
end
