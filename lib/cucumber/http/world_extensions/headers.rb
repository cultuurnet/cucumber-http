module Cucumber
  module Http
    module Headers
      def headers
        @headers ||= {}
      end

      def add_header(key, value)
        headers[key.to_sym] = value
      end

      def remove_header(key)
        headers.tap { |hdrs| hdrs.delete(key.to_sym)}
      end

      def clear_headers
        headers.clear
      end
    end
  end
end

World(Cucumber::Http::Headers)
