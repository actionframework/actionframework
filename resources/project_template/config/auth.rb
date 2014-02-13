# Add your Warden configuration here
# Example:   				
# manager.default_strategies :password

# To load your strategies from #{PROJECT_ROOT}/authentication/yourstrategy.rb use:
# ActionFramework::Authentication::Strategy.load("yourstrategy")

# You also need to setup your session serialisation:
#  Warden::Manager.serialize_into_session do |user|
#  	user.id
#  end
#
#  Warden::Manager.serialize_from_session do |id|
#   User.get(id)
#  end