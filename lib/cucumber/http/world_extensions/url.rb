module Cucumber
  module Http
    module Url
      def url
        @url ||= ''
      end

      def set_url(string)
        url.replace(string)
      end

      def clear_url
        url.clear
      end
    end
  end
end

World(Cucumber::Http::Url)
