module ActionFramework
	module Authentication
	   class Strategy
	   	 	def self.load(strategyname)
	   	 		require "./authentication/#{strategyname}"
	   	 	end
	   end
	end
end