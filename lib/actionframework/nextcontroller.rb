require 'rack'
require 'actionframework/controller'
require 'actionframework/template_manager'

module ActionFramework
  class ThisObject
    def method_missing(meth,*args,&block)
      if(meth.to_s.include?("="))
        instance_variable_set("@"+meth.to_s.gsub("=",""),args[0])

        create_method(meth.to_s.gsub("=","")) do
          instance_variable_get("@"+meth.to_s.gsub("=",""))
        end
      else
        super
      end
    end

    def create_method( name, &block )
          self.class.send( :define_method, name, &block )
    end
  end

  class NextControllerError < StandardError

  end

  module NextController
      attr_accessor :klass
      attr_accessor :method
      attr_accessor :nexts
      attr_accessor :nextElementPlace
      attr_accessor :neep
      attr_writer :this


      def setup(req,res,url,nexts)
        this.request = req
        this.response = res
        this.url = url
        @nexts = nexts
      end

      def goNext(ctx)
        raise  ActionFramework::NextControllerError,"No \"next\" found, check your routes.rb" unless ctx.nexts.length > ctx.neep+1

        klass,method = ctx.nexts[ctx.neep].split("#")[0],ctx.nexts[ctx.neep].split("#")[1]
        klass_inst = Object.const_get(klass).new
        klass_inst.this = ctx.this
        klass_inst.nexts = ctx.nexts
        klass_inst.setNext(ctx.neep+1)
        klass_inst.send(method)

      end

      def setNext(nextElementPlace)
        @neep = nextElementPlace
      end

      def this
        if(@this.nil?)
          @this = ActionFramework::ThisObject.new
        end
        @this
      end

      def erb(templatename)
        ActionFramework::TemplateManager::Erb.render(templatename,self)
      end
  end
end
