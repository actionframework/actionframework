module ActionFramework
	
	def ErrorHandler < ActionFramework::Controller
		def error_404
			erb_text "<h1>Error 404</h1>"
		end

		def error_500
			erb_text "<h1>Error 500</h1>"
		end

		def error_403 
			erb_text "<h1>Error 403</h1>"
		end
	end

end