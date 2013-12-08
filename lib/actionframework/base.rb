#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################
module ActionFramework
	# Base class (in config.ru -> run ActionFramework::Base.start)
	class Base
		def initialize
			@app = Rack::Builder.new do
				map '/static' do
					run Rack::File.new("static")
				end

				map '/realtime' do
					run ActionFramework::Realtime.new
				end
				
	       	  	run ActionFramework::Server.current
	       	end
		end

		def call env
			@app.call(env)
		end
	end
end