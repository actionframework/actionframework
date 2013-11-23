#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################

module ActionFramework
	class Controller
		def initialize req,res,url
			@req = req
			@res = res
			@url = url
		end

		def request
			@req
		end

		def response
			@res
		end

		def params
			@req.params
		end

		def url
			@url
		end
	end
end