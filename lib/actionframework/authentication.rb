module ActionFramework
	module Authentication
	   class Strategy
	   	 	def self.load(stategyname)
	   	 		require "./authentication/#{strategyname}"
	   	 	end
	   end
	end
end