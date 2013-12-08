#######################
# Licenced under MIT ##
### © BramVDB.com #####
#######################

# @author BramVDB.com
# @since 0.1.1
class String
	# @return [String] Classified string
	def classify
		self.split('_').collect(&:capitalize).join 
	end
end