module ActionFramework
  class RealtimeController
      attr_accessor :url
      attr_accessor :req
      attr_accessor :env
      attr_accessor :payload

      def initialize(url,req,env,payload,socket)
        @url = url
        @req = req
        @env = env
        @payload = payload
        @socket = socket
      end

      def request
        @req
      end

      def socket
        @socket
      end

      def on_open

      end

      def on_close

      end

      def on_message

      end
  end
end
