#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################

module ActionFramework
	class Routes
		attr_accessor :routes
		def initialize
			@routes = {:get => {}, :post => {}, :update => {}, :delete => {}, :patch => {}}
		end

		def build_regex string
			string = string.gsub("{{","(?<")
			string = string.gsub("}}",">(.*))") 
			string.insert(0,"^")
			string = string+"$"
			regex = Regexp.new (string)
			regex
		end

		def get hash
			@routes[:get][build_regex(hash.keys.first.to_s)] = hash[hash.keys.first.to_s] 
		end

		def post hash
			@routes[:post][build_regex(hash.keys.first.to_s)] = hash[hash.keys.first.to_s] 
		end

		def update hash
			@routes[:update][build_regex(hash.keys.first.to_s)] = hash[hash.keys.first.to_s] 
		end

		def delete hash
			@routes[:delete][build_regex(hash.keys.first.to_s)] = hash[hash.keys.first.to_s] 
		end

		def patch hash
			@routes[:patch][build_regex(hash.keys.first.to_s)] = hash[hash.keys.first.to_s] 
		end

		def route(path,method)
			@routes[method.downcase.to_sym].each do |regex,controller|
				puts regex
				p regex
				if(matched = path.match(regex))
					return [controller,matched]
				end
			end
			return nil
		end
	end
end