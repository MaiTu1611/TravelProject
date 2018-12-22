class WelcomeController < ApplicationController
  	def index
  		@travels = Travel.all
  	end
end
