#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################
module ActionFramework
	# Base class (in config.ru -> run ActionFramework::Base.start)
	class Base
		def self.start
			app = Rack::Builder.new do
				map '/realtime' do
					run ActionFramework::Realtime.new
				end
	       	  	run ActionFramework::Server.current
	       	end
		end
	end
end