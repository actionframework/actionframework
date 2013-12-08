#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################
require 'rack/websocket'

module ActionFramework
	class Realtime < Rack::WebSocket::Application
		def on_open env
			
			puts "Client connected"
		end
	end
end