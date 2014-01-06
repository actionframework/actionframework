require 'json'

module ActionFramework
	class RealtimeMessage
		def initialize(socket)
			@sock = socket
		end

		def post identifier,payload
			@sock.puts({:identifier => identifier,:payload => payload}.to_json)
		end
	end
end