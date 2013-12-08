module Gem
	class Specification
		def self.find_lib_dir_by_name name
			spec = Gem::Specification.find_by_name(name)
			gem_root = spec.gem_dir
			gem_lib = gem_root + "/lib"
			gem_lib
		end
	end
end