module ActionFramework
	class Mailer
		def self.config
			ActionMailer::Base.class_eval
			ActionMailer::Base.view_paths = "./views/mailer/"
		end
	end
end