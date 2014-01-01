#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################

module ActionFramework
	class Model
	  include EventEmitter

	  def update_attributes data
	  	super
	  	self.emit :updated_attributes,data
	  end

	  def self.create data
	  	super
	  	self.emit :created,data
	  end
	end
end