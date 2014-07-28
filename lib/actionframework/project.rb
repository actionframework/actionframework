module ActionFramework
  class Project
      def self.autoimport
          Dir.glob("controllers/*.rb").each do |file|
            require './'+file
          end

          Dir.glob("controller/mailers/*.rb") do |file|
            require './'+file
          end

          Dir.glob("models/*.rb").each do |file|
            require './'+file
          end

          require './config/routes'
          require './config/settings'
          require './config/plugables'
          require './config/mailer'

          require './config/realtime' unless !File.exist?("./config/realtime.rb")

          Dir.glob("initializers/*.rb").each do |file|
            require './'+file
          end
      end
  end
end
