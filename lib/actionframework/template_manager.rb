module ActionFramework
  module TemplateManager

    class Erb
      def self.render(templatename,ctx)
        class << ctx
            public :eval
        end

        anwser = ctx.eval('renderer = Tilt::ERBTemplate.new("views/layout.html.erb");
        output = renderer.render(self){ Tilt::ERBTemplate.new("views/"+'+template.to_s+'+".html.erb").render(self) }')
        anwser
      end
    end

  end
end
