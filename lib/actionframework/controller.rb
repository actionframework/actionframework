#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################

module ActionFramework
	class Controller
		@@run_before = []

		def initialize env,req,res,url
			@req = req
			@res = res
			@url = url
			@env = env
		end

		def env
			@env
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
      			renderer = Tilt::ERBTemplate.new(libdir+"/views/errors/layout.html.erb")
	      		output = renderer.render(self){ Tilt::ERBTemplate.new(libdir+"/views/errors/#{code}.html.erb").render(self) }
      		end
		end

		def session
			@req.session
		end

		def redirect path
			response.redirect path
			""
		end

		def self.run_before(*args)
			args.each do |methodname|
					@@run_before << methodname
			end
		end

		def execute_run_before
			output = nil
			@@run_before.each do |methodname|
				returns = self.send(methodname)

				if(returns.class.to_s == "String")
					output = returns
					break
				end

			end

			return output
		end

		def _static filename
			File.read("./views/_/#{filename}.html")
		end

		def _erb templatename,context=self
			renderer = Tilt::ERBTemplate.new("./views/#{templatename}")
			renderer.render(context)
		end


		# Legacy support for partials
		def _render filename
			File.read("./views/_/#{filename}.html")
		end
		
	end
end
