require 'rest-client'

module Cucumber
  module Http
    module Request
      def request
        @request ||= {}
      end

      def set_request(key, value)
        request[key.to_sym] = value
      end

      def perform_request(method, path)
        add_header('params', parameters)

        request_payload = multipart_payload.empty? ? payload : multipart_payload

        begin
          r = RestClient::Request.execute(
            method: method.downcase,
            url: path,
            headers: headers,
            payload: request_payload
          )
        rescue RestClient::Exception => e
          r = e.response
        end

        set_request('url', path)
        set_request('method', method.upcase)
        set_request('headers', headers.tap { |hdrs| hdrs.delete('params')})
        set_request('parameters', parameters)
        set_request('payload', request_payload)

        set_response('status', r.code)
        set_response('body', r.body)
        set_response('headers', r.raw_headers)

        clear_multipart_payload
        clear_payload
      end

      def clear_request
        request.clear
      end
    end
  end
end
