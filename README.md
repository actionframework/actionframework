ActionFramework
===============

![ActionFramework logo](https://raw.github.com/actionframework/actionframework/master/logo.png)

[![Code Climate](https://codeclimate.com/github/actionframework/actionframework.png)](https://codeclimate.com/github/actionframework/actionframework)

** Warning: This framework is developping fast, so a new minor release can include breaking changes with your existing code. We will create a changelog soon so you can follow that.**

Ready for action? Ready, set, go!

ActionFramework is a web application framework for Ruby.   
It's meant for rapid and fun development of your application.

Because of that it is easy understandable and easy to use and customize.    
Want some documentation? Read the source code.

# Requirements

It just requires Ruby and RubyGems.    
I have tested it with Ruby version 1.9.3.

# Installation

You can install this framework with the following command:

    [sudo] gem install actionframework

# Getting started

You can easily create a project by running:

    afw new projectname 

This will create a basic directory structure needed by ActionFramework in order to run correctly. It will also create a Gemfile and will run "bundle install" in the project directory.

After that, you can directly test your application by running:

    afw s


## Directory structure

    .
	├── Gemfile
	├── config
	│   ├── routes.rb
	│   └── settings.rb
	├── controllers
	│   └── default_controller.rb
	├── initializers
	├── models
	└── views
	    └── layout.html.erb

This directory structure will be created by the CLI. It's very similar to Rails, so it will be very familiar for the people already familiar to Rails development.

First, you have a "Gemfile", in this file you are going to specifiy the dependencies for your project. For example when you want to use DataMapper as your ORM, you can do that by adding:

     gem 'datamapper'

to your Gemfile.     

Next, we have a directory called "config", this directory is used to store configuration files. Let's begin with the routes.rb file.

### Routes

You can specify your routes in the "routes.rb" file which you can find in the "config" directory.

Specifying routes is very similar to Rails:

     ActionFramework::Server.current.routes do
     	# A get route:
     	get "/PATH" => "ControllerName#method"
     	# A post route:
     	post "/PATH" => "ControllerName#method"
     	# etc
     end

You can also use "placeholders" in your routes path.    
So for example you have a profile page and you want to dynamicly load a user his/her profile from their "id".

	ActionFramework::Server.current.routes do
		get "/profile/{{id}}" => "ProfileController#profile"
	end

### Controllers

Controllers are loaded from the "controller" directory.

They're deadly easy to use.
I will give you an example:

     class ControllerName
		def method
			"Return a string as a response"
		end
     end

But what if you wan't to use templates, like ERB.
ActionFramework has built-in support for ERB templates.

	class ControllerName
		def method
			erb "templatename"
		end
	end

### Templating

Templates are loaded from the "views" directory

Their filename must match the following pattern: "TEMPLATENAME.html.erb"
In the "views" folder, there also is a file called "layout.html.erb", this file is used to make headers and footers if you like.

# Other documentation

I hope this README is clear enough for your to understand how you can use this framework to build your next awesome application. If you have any questions please contact me at [Twitter](https://www.twitter.com/bramvdbogaerde).

# State of development

Currently the framework is in an alpha stage, but I'm working very hard to get it production ready.    
Version 1.0.0, will be the first stable release and it will bring a website with full documentation. If you like the project please "star" it!

# Licence

MIT