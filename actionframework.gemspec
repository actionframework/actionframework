Gem::Specification.new do |s|
  libfolder = Dir.glob("lib/**/**/**")
  resourcesfolder = Dir.glob("resources/**/**/**/**")
  files = libfolder.concat(resourcesfolder)

  s.name        = 'actionframework'
  s.version     = '0.3.0'
  s.date        = '2014-12-07'
  s.summary     = "A web framework built on top of Rack"
  s.description = "A web framework built on top of Rack, it has the simplicity of sinatra and the structure of rails"
  s.authors     = ["Bram Vandenbogaerde"]
  s.email       = 'bram.vandenbogaerde@gmail.com'
  s.files       = files
  s.homepage    =
    'http://actionframework.bramvdb.com'
  s.license = "MIT"
  s.add_runtime_dependency "tilt"
  s.add_runtime_dependency "json"
  s.add_runtime_dependency "rack"
  s.add_runtime_dependency "optitron"
  s.add_runtime_dependency "websocket-rack"
  s.add_runtime_dependency "httparty"
  s.add_runtime_dependency "jewel"
  s.add_runtime_dependency 'omniauth', '~> 1.0'
  s.add_runtime_dependency 'event_emitter'
  s.add_runtime_dependency "warden"
  s.add_runtime_dependency "actionmailer"
  s.add_runtime_dependency "redis"
  s.add_runtime_dependency "tubesock"
  s.add_runtime_dependency "websocket"

  s.executables = ["action"]
end
