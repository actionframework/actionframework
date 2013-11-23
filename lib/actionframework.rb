require 'rack'
require 'tilt'
require 'json'
require 'erb'

require 'actionframework/routes'
require 'actionframework/controller'

$runningserver = nil

module ActionFramework
	class Server
		def initialize
			@routesklass = ActionFramework::Routes.new
			@settings = ActionFramework::Settings.new
		end

		def self.init
	      require 'bundler'
	      Bundler.require(:default)
	      $runningserver = ActionFramework::Server.new
	      $runningserver.autoimport
	    end
		
		def self.current
	       if($runningserver.nil?)
	         ActionFramework::Server.init
	         $runningserver
	       else
	         $runningserver
	       end
	    end
	    
	    def self.current=(runningserver)
	      $runningserver = runningserver
	    end

	    def autoimport
	      Dir.glob("controllers/*").each do |file|
	        require './'+file
	      end

	      Dir.glob("models/*").each do |file|
	        require './'+file
	      end

	      require './config/routes'
	      require './config/settings'

	      Dir.glob("initializers/*").each do |file|
	        require './'+file
	      end

	    end

		def call env
			req = Rack::Request.new(env)
			res = Rack::Response.new

			controllerinfo = @routesklass.route(req.path,req.request_method)
			if(controllerinfo == nil)
				res.write "<h1>404 Not found</h1>"
				return res.finish
			end	

			controller = controllerinfo[0]
			matcheddata = controllerinfo[1]

			control = controller.split("#")
			result = Object.const_get(control[0]).new(req,res).send(control[1])			
			res.body = [result]
			res.finish
		end
		def routes &block
			@routesklass.instance_eval &block
		end

		def settings
			yield @settings
		end

		def start
	      Rack::Server.new({:app => self,:server => @settings.server, :Port => @settings.port}).start
	    end
	end	

	class Settings

	end
end