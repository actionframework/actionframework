#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################

require 'rack/websocket'
require 'socket'
require 'json'
require 'redis'
require 'tubesock'

$redis = Redis.new
module ActionFramework
	class Realtime

		def call(env)
				tubesock = Tubesock.hijack(env)
				tubesock.listen
				
				@sock = tubesock

				tubesock.onmessage do |message|
					on_message(env,message);
				end

				tubesock.onopen do
					on_open(env)
				end

				tubesock.onclose do
					on_close(env)
				end
		    [ -1, {}, [] ]
		end

		def on_open(env)
			request = Rack::Request.new(env)
			perform_action(env,request,request.path,"on_open",nil)
		end

		def on_message(env,message)
			request = Rack::Request.new(env)
			perform_action(env,request,request.path,"on_message",message)
		end

		def on_close(env)
			request = Rack::Request.new(env)
			perform_action(env,request,request.path,"on_close",nil)
		end

		def self.configure
			$realtime_config = RealtimeConfigure.new
			yield($realtime_config)
		end


		def perform_action(env,req,path,method,payload)
			matchedroute = ActionFramework::Server.current.routesklass.route(path,"realtime")
			controller,url = matchedroute[0],matchedroute[1]

			Object.const_get(controller).new(url,req,env,payload,@sock).send(method,payload)
		end
	end

	class RealtimeConfigure
		attr_accessor :enabled
	end
end
