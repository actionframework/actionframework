module ActionFramework
	
	class ErrorHandler < ActionFramework::Controller
		def error_404
			error_erb "404"
		end

		def error_500
			error_erb "500"
		end

		def error_403 
			error_erb "403"
		end
	end

end