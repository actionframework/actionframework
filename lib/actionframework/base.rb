#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################
require 'warden'

module ActionFramework
	# Base class (in config.ru -> run ActionFramework::Base.new)
	class Base
		def initialize
			@app = Rack::Builder.new do
				map '/static' do
					run Rack::File.new("static")
				end

				map '/realtime' do
					run ActionFramework::Realtime.new
				end
				
				use Warden::Manager do |manager|
  					manager.default_strategies :password
  					manager.failure_app = ActionFramework::Server.current
				end
	       	  	
	       	  	run ActionFramework::Server.current
	       	end
		end

		def call env
			@app.call(env)
		end
	end
end