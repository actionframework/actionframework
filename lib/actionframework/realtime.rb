#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################
require 'rack/websocket'
require 'socket'
require 'json'

module ActionFramework
	class Realtime < Rack::WebSocket::Application

		def initialize
			super
			@nosocket = true
		
			begin 
				socket = UNIXSocket.new("./realtime.socket")
				@nosocket = false
				@message = ActionFramework::RealtimeMessage.new(socket)
			rescue
				puts "Socket not used in this application"
			end
		end

		def on_open env
			return exit_me unless @nosocket
			@message.post("client_connected",{:env => env,:msg => msg})
		end

		def on_close env
			
		end

		def on_message env,msg
			@message.post("client_message",{:env => env,:msg => msg})
		end

		def exit_me
			puts "INFO: No Unix Socket found, your application doesn't implement the realtime API"
		end
	end
end