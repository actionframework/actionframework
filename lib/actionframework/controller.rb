r#######################
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

		def erb template
      		renderer = Tilt::ERBTemplate.new("views/layout.html.erb")
      		output = renderer.render(self){ Tilt::ERBTemplate.new("views/"+template.to_s+".html.erb").render(self) }
      		return output
		end

		def erb_text erb_text
			renderer = Tilt::ERBTemplate.new("views/layout.html.erb")
      		output = renderer.render(self){ erb_text }
      		return output
		end
	end
end