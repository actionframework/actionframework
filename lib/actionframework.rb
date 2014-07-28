require 'rack'
require 'tilt'
require 'json'
require 'erb'
require 'action_mailer'

require 'actionframework/string'
require 'actionframework/gemextra'
require 'actionframework/gem'
require 'actionframework/routes'
require 'actionframework/controller'
require 'actionframework/controller_supervisor'
require 'actionframework/settings'
require 'actionframework/error_handler'
require 'actionframework/modelhelper'
require 'actionframework/realtime'
require 'actionframework/base'
require 'actionframework/authentication'
require 'actionframework/mailer'
require 'actionframework/project'
require 'event_emitter'



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
					 ActionFramework::Project.autoimport
	         $runningserver
	       else
	         $runningserver
	       end
	    end

	    def self.current=(runningserver)
	      $runningserver = runningserver
	    end

			# DEPRECATED This method will soon be removed in favor of ActionFramework::Project.autoimport
	    def autoimport

	     ActionFramework::Project.autoimport

	    end

		def call env
			req = Rack::Request.new(env)
			res = Rack::Response.new

			# redirection
			redirect = @routesklass.redirect? req
			if(!redirect.nil?)
				res.redirect(redirect.to)
				return res.finish
			end


			# auto-api feature (only at path /api/*)
			reso = getModelResponse(req,res)
			if(!reso.nil?)
				return reso
			end

			controllerinfo = @routesklass.route(req.path,req.request_method)
			if(controllerinfo == nil)
				res.body = [ActionFramework::ErrorHandler.new(env,req,res,{}).send("error_404")]
				res.status = 404
				return res.finish
			end

			controller = controllerinfo[0]
			matcheddata = controllerinfo[1]

			result = ActionFramework::ControllerSupervisor.new.run(controller,env,req,res,matcheddata)
			res.write result
			res.finish
		end
		def routes &block
			@routesklass.instance_eval &block
		end

		def settings
			yield @settings
		end

		def get_settings
			@settings
		end

		def start
	      Rack::Server.new({:app => self,:server => @settings.server, :Port => @settings.port}).start
	    end

	    def getModelResponse req,res
	    	if(matcheddata = req.path.match(Regexp.new("/api/(?<modelname>(.*))")))
	    			return nil unless @routesklass.models.include?(matcheddata[:modelname])

					res["Content-type"] = "application/json"
					model = Object.const_get(matcheddata[:modelname].capitalize)
					model.instance_variable_set("@req",req)

					case req.request_method
					when "POST"
						return ActionFramework::ModelHelper.post model,req,res
					when "GET"
						return ActionFramework::ModelHelper.get model,res
					when "UPDATE"
						return ActionFramework::ModelHelper.update model,res
					when "DELETE"

					else

					end
			end
			nil
	    end
	end
end
