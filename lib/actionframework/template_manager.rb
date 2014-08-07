module ActionFramework
  module TemplateManager

    class Erb
      def self.render(template,ctx)
        class << ctx
            public :eval
        end

        renderer = Tilt::ERBTemplate.new("views/layout.html.erb");
        output = renderer.render(ctx){ Tilt::ERBTemplate.new("views/"+template.to_s+".html.erb").render(ctx) }

      end
    end

  end
end
