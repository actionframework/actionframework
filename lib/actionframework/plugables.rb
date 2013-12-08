#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################

module ActionFramework
	class Plugables
		def initialize &block
			@index = JSON.parse(File.read(Gem::Specification.find_lib_dir_by_name("actionframework")+"/plugables/index.json"))
			self.instance_eval &block
		end

		def plug name
			if @index["plugs"].include? name
				require Gem::Specification.find_lib_dir_by_name("actionframework")+'/plugables/'+name
			end
			Object.const_get(name.classify).new if(Object.const_get(name.classify).superclass.to_s == "ActionFramework::Plugable::Initializer")
		end
	end
end