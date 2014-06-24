#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################

require 'rack/websocket'
require 'socket'
require 'json'
require 'redis'

$redis = Redis.new
module ActionFramework
	class Realtime < Rack::WebSocket::Application
		def on_open(env)
			return unless $realtime_config.enabled
			request = Rack::Request.new(env)

			$redis.publish request.path, env["HTTP_SEC_WEBSOCKET_KEY"]

			$redis.subscribe env["HTTP_SEC_WEBSOCKET_KEY"] do |on|
				on.message do |channel,message|
					send_data message
				end
			end
		end

		def on_message(env,message)
			$redis.publish env["HTTP_SEC_WEBSOCKET_KEY"], message
		end

		def on_close(env)

		end

		def self.configure
			$realtime_config = RealtimeConfigure.new
			yield($realtime_config)
		end

	end

	class RealtimeConfigure
		attr_accessor :enabled
		## Redis might not fit your needs, that's why I will make something that your can plug your own server of choice into the websockets by using the predefined callbacks
		attr_accessor :redis_prefix
		attr_accessor :redis_uri
	end
end
