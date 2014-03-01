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
				# Initialize ActionFramework itself
				ActionFramework::Server.current

				map '/static' do
					run Rack::File.new("static")
				end

				map '/realtime' do
					run ActionFramework::Realtime.new
				end

				use Rack::Session::Cookie, :secret => ActionFramework::Server.current.settings.cookie_secret
				
				use Warden::Manager do |manager|
					config = File.read('./config/auth.rb')
					manager.failure_app = ActionFramework::Server.current

  					eval config
				end

	       	  	# Run ActionFramework
	       	  	run ActionFramework::Server.current
	       	end
		end

		def call env
			@app.call(env)
		end
	end
end