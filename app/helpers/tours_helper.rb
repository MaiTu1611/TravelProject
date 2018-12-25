module ToursHelper
	def parse_category(categoryNum)
	    case categoryNum
	    when 0 then "Chờ duyệt"
	    when 1 then "Đã duyệt"
	    else "Hủy"
	    end
	  end
end
