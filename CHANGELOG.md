Changelog ActionFramework
===============

# What is this?

This a a changelog, you can find the changes made between major versions.    
We define major version a version that is published to RubyGems.org.     

# Version 0.1.0 to 0.1.3

This version includes to following:

- Development started of Realtime API (f974159f0a6313a84913de6329a0fb9c0445b2d3)
- Static files can now be stored at the 'static' folder (17df53aa65e1c6f3ced9e307bc4119d818110927)
- Started development of Plugables(more information available soon) (1d2fbfb0365af3c4184908956aae9df23cb4e089)
- Error templates (ef8214cd232069caabb7785c76551670bc590c25)

## Breaking changes

We have moved complety over to "config.ru". This will be automaticly created with the CLI.     
Also, if you previously used to write the following in your "config.ru":

    require 'actionframework'
	
	run ActionFramework::Server.current

This will no longer load all the features of ActionFramework, instead you should write this:

    require 'actionframework'
	
	run ActionFramework::Base.new

## Documentation and website

I have registered the domain "actionframework.io" and I am currently developping a website for it. I will publish it on Github when it is ready.

# Future versions

With version 0.1.3 the main features are finally finisched, like error handling, routing and templating. The next version should include the following features:

- Auto-api (I will publish more information about this soon)
- Better greeting message when the user create its first project
