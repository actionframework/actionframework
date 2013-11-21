ActionFramework
===============

Ready for action? Ready, set, go!

ActionFramework is a web application framework for Ruby.   
It's meant for rapid and fun development of your application.

Because of that it is easy understandable and easy to use and customize.    
Want some documentation? Read the source code.

# Requirements

It just requires Ruby and RubyGems.    
I have tested it with Ruby version 1.9.3.

# Documentation

Like I said read the source code, but why?

Currently ActionFramework is in an alpha stage of the framework. This means that it is under heavy development and not really ready to use in production envoirements.

Because it is in the alpha stage, I have not had the time to create the documentation, but I think the source code is not very hard to understand, and ActionFramework includes a very nice commandline utility, so you can run "afw new projectname" and you are ready to go!

# Installation

You can install this framework with the following command:

    [sudo] gem install actionframework

# Create your first project

You can easily create a project by running:

    afw new projectname 

This will create a basic folder structure and some files.    
It might still have some references to "GORS", this was the name the framework had in the past. This might also create some errors, this can be solved by creating an initializer in the folder "initializers", named for example "oldnamesolver.rb". You need to put the following in that file:

     module Gors
    	include ActionFramework
     end

When you did that, you can start your first application by running:

    afw s

More documentation will be available very soon.

# State of development

Currently the framework is in an alpha stage, but I'm working very hard to get it production ready.    
Version 1.0.0, will be the first stable release and it will bring a website with full documentation. If you like the project please "star" it!

# Licence

MIT