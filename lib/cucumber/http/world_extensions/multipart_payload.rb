module Cucumber
  module Http
    module Payload
      def multipart_payload
        @multipart_payload ||= {}
      end

      def add_multipart_payload(key, value)
        multipart_payload[key] = value
      end

      def remove_multipart_payload(key)
        multipart_payload.tap { |p| p.delete(key)}
      end

      def clear_multipart_payload
        multipart_payload.clear
      end
    end
  end
end
