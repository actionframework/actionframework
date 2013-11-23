module ActionFramework
	class Settings
		attr_accessor :server
		attr_accessor :port
		attr_accessor :errorhandler

		def initialize
			@port = 3000
			@server = "thin"
		end	
	end
end	