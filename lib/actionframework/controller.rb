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

		def error_erb code
			if(Dir.exists? "views/errors")
				renderer = Tilt::ERBTemplate.new("views/layout.html.erb")
	      		output = renderer.render(self){ Tilt::ERBTemplate.new("views/errors/#{code}.html.erb").render(self) }
	      		return output
      		else
      			root = ActionFramework::Gem.root
      			libdir = root.resources.to_s
      			puts ActionFramework::Gem.root.inspect
      			renderer = Tilt::ERBTemplate.new(libdir+"/views/errors/layout.html.erb")
	      		output = renderer.render(self){ Tilt::ERBTemplate.new(libdir+"/views/errors/#{code}.html.erb").render(self) }
      		end
		end

		def session
			@req.session
		end
	end
end