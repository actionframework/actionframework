module ActionFramework
  class RealtimeController
      attr_accessor :url
      attr_accessor :req
      attr_accessor :env
      attr_accessor :payload

      def initialize(url,req,env,payload)
        @url = url
        @req = req
        @env = env
        @payload = payload
      end

      def request
        @req
      end
  end
end
