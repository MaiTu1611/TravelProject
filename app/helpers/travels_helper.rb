module TravelsHelper
	def number_to_vnd(amount)
	  number_to_currency(amount, precision: 0, unit: "VND", format: "%n %u")
	end
end
