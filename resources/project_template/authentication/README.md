Authentication
===================

The files in this directory can be Warden strategies, Warden is the built-in authentication framework.

The strategies can be loaded with the following code from an initializer.

	ActionFramework::Authentication::Strategy.load("yourstrategy")
	