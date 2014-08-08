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
			request = Rack::Request.new(env)
			perform_action(env,request.path,"on_open",nil)
		end

		def on_message(env,message)
			request = Rack::Request.new(env)
			perform_action(env,request.path,"on_message",message)
		end

		def on_close(env)
			request = Rack::Request.new(env)
			perform_action(env,request.path,"on_close",nil)
		end

		def self.configure
			$realtime_config = RealtimeConfigure.new
			yield($realtime_config)
		end


		def perfom_action(env,path,method,payload)
			matchedroute = ActionFramework::Server.current.routes.route(path,"realtime")
			controller,url = matchedroute[0],matchedroute[1]

			Object.const_get(controller).new(url,req,env,payload).send(method,payload)
		end
	end

	class RealtimeConfigure
		attr_accessor :enabled
	end
end
