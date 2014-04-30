module ActionFramework
	class Mailer
		def self.config &block
			ActionMailer::Base.class_eval &block
			ActionMailer::Base.view_paths = "./views/mailer/"
		end
	end
end
