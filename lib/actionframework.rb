require 'rack'
require 'tilt'
require 'json'
require 'erb'

require 'actionframework/string'
require 'actionframework/routes'
require 'actionframework/controller'
require 'actionframework/settings'
require 'actionframework/error_handler'
require 'actionframework/modelhelper'
require 'actionframework/realtime'
require 'actionframework/base'

$runningserver = nil

module ActionFramework
	class Server
		def initialize
			require 'bundler'
			Bundler.require(:default)
			
			@routesklass = ActionFramework::Routes.new
			@settings = ActionFramework::Settings.new
		end

		def self.current
	       if($runningserver.nil?)
	       	 $runningserver = ActionFramework::Server.new
	       	 $runningserver.autoimport
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

			# auto-api feature (only at path /api/*)
			getModelResponse req,res

			controllerinfo = @routesklass.route(req.path,req.request_method)
			if(controllerinfo == nil)
				res.body = [ActionFramework::ErrorHandler.call("error_404")]
				return res.finish
			end	

			controller = controllerinfo[0]
			matcheddata = controllerinfo[1]

			control = controller.split("#")
			result = Object.const_get(control[0]).new(req,res,matcheddata).send(control[1])			
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

	    def getModelResponse req,res
	    	# auto-api start
	    	# [todo] add api security with policies 
	    	if(matcheddate = req.path.match(Regexp.new("^/api/(?<modelname>(.*))$")))
				policy = @routesklass.models[matcheddata[:modelname]]
				if(policy != nil)
					res.headers = {"Content-type" => "application/json"}
					model = Object.const_get(matcheddata[:modelname])
					case req.request_method
					when "POST"
						ActionFramework::ModelHelper.post model,res
					when "GET"
						ActionFramework::ModelHelper.get model,res
					when "UPDATE"
						ActionFramework::ModelHelper.update model,res
					when "DELETE"
						
					else

					end

				end
			end
			# end auto-api
	    end

	end	
end
