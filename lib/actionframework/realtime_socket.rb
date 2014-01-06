require 'socket'
require 'securerandom'

module ActionFramework
	class RealtimeSocket
		def initialize
			@sock = UNIXServer.new("realtime.sock")
		end

		def listen
			$pid = Procces.fork do
				while(client = @sock.accept)
					while(line = client.gets)
						yield
					end
				end
			end
		end
	end
end