#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################

module ActionFramework
	class Controller
		def initialize req,res
			@req = req
			@res = res
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
	end
end