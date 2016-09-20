require 'rest-client'

module Cucumber
  module Http
    module Request
      def perform_request(method, path)
        add_header('params', parameters)

        begin
          r = RestClient::Request.execute(
            method: method.downcase,
            url: path,
            headers: headers,
            payload: payload
          )
        rescue RestClient::Exception => e
          r = e.response
        end

        set_response('status', r.code)
        set_response('body', r.body)
        set_response('headers', r.headers)
      end
    end
  end
end

World(Cucumber::Http::Request)
