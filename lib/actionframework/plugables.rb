#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################

module ActionFramework
	class Plugables
		def self.setup &block
			self.instance_eval &block
		end

		def plug name
			Object.const_get(name.classify).new if(Object.const_get(name.classify).superclass.to_s == "ActionFramework::Plugable::Initializer")
		end
	end
end