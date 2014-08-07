require 'rack'

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

  module NextController
      attr_accessor :klass
      attr_accessor :method
      attr_accessor :nexts
      attr_writer :this

      def setup(env)
        this.request = Rack::Request.new(env)
        this.response = Rack::Response.new(env)
      end

      def goNext(ctx)

      end

      def setNext(methodString,nexts)

      end

      def this
        if(@this.nil?)
          @this = ActionFramework::ThisObject.new
        end
        @this
      end
  end
end
