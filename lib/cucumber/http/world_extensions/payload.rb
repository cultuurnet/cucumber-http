module Cucumber
  module Http
    module Payload
      def payload
        @payload ||= ''
      end

      def set_payload(data)
        payload.replace(data)
      end

      def clear_payload
        payload.clear
      end
    end
  end
end
