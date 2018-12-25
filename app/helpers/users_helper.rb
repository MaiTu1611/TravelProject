module UsersHelper
	def convert_role
		if value == "admin"
			1
		else
			2
		end
	end
end
