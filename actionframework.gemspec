Gem::Specification.new do |s|
  s.name        = 'actionframework'
  s.version     = '0.1.3'
  s.date        = '2013-11-20'
  s.summary     = "A web framework built on top of Rack"
  s.description = "A web framework built on top of Rack, it has the simplicity of sinatra and the structure of rails"
  s.authors     = ["Bram Vandenbogaerde"]
  s.email       = 'bram.vandenbogaerde@gmail.com'
  s.files       = Dir.glob("lib/**/**/**")
  s.homepage    =
    'http://rubygems.org/gems/actionframework'
  s.license = "MIT"
  s.add_runtime_dependency "tilt"
  s.add_runtime_dependency "json"
  s.add_runtime_dependency "rack"
  s.add_runtime_dependency "optitron"
  s.add_runtime_dependency "websocket-rack"
  s.add_runtime_dependency "httparty"
  s.add_runtime_dependency "jewel"


  s.executables = ["action"]
end