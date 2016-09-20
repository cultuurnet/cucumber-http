module Cucumber
  module Http
    module Response
      def response
        @response ||= {}
      end

      def set_response(key, value)
        response[key.to_sym] = value
      end

      def clear_response
        response.clear
      end
    end
  end
end

World(Cucumber::Http::Response)
