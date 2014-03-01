module ActionFramework
	class Settings
		attr_accessor :server
		attr_accessor :port
		attr_accessor :errorhandler
		attr_accessor :cookie_secret

		def initialize
			@port = 3000
			@server = "thin"
		end	
	end
end	