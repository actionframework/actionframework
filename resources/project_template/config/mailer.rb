ActionFramework::Mailer.config do 
	delivery_method = :smtp
	smtp_settings = {
	   :address   => "smtp.example.com",
	   :port      => 587,
	   :domain    => "example.com",
	   :authentication => :plain,
	   :user_name      => "root",
	   :password       => "password",
	   :enable_starttls_auto => true
	}
end