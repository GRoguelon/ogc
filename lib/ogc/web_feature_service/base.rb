require 'ogc/exceptions'

require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/object/to_query'
require 'active_support/core_ext/string/inflections'
require 'nokogiri'

module Ogc
  module WebFeatureService
    class Base
      include Exceptions

      attr_reader :params, :response, :url

      DEFAULT_PARAMS = { 'service' => 'wfs' }.freeze

      class << self
        def request_name
          @request_name ||= to_s.demodulize
        end
      end

      def initialize(url, params = nil)
        @url    = url
        @params = (params ? params.stringify_keys : {}).merge!(DEFAULT_PARAMS)
      end

      def get(extra_params, &block)
        params = extra_params ? extra_params.merge(@params) : @params
        fetch(:get, params, &block)
      end

      def post(body, &block)
        fetch(:post, body.respond_to?(:to_xml) ? body.to_xml : body, &block)
      end

      def http
        @http ||= Net::HTTP.new(uri.host, uri.port)
      end

    private

      def fetch(type, content, &block)
        request = request(type, content)
        block.call(request) if block
        handle_response(request)
      end

      def handle_response(request)
        case (response = http.request(request))
        when Net::HTTPSuccess
          @response = Nokogiri::XML(response.body.clean_xml!).tap do |xml|
            # rubocop:disable Style/RaiseArgs
            raise ExceptionReport.new(xml) if ExceptionReport.exception?(xml)
            # rubocop:enable Style/RaiseArgs
          end
        else
          # rubocop:disable Style/RaiseArgs
          raise RequestFailedException.new(response)
          # rubocop:enable Style/RaiseArgs
        end
      rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
             Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError,
             Net::ProtocolError
        raise RequestErrorException
      end

      def request(type, content)
        case type
        when :get then Net::HTTP::Get.new(uri_with_params(content))
        when :post
          Net::HTTP::Post.new(uri_without_params).tap do |req|
            req.body = content
          end
        end
      end

      def uri_with_params(extra_params)
        return uri_without_params if extra_params.blank?

        uri_without_params.dup.tap do |uri|
          www_form  = Hash[URI.decode_www_form(uri.query.to_s)]
          uri.query = www_form.merge!(extra_params).to_query
        end
      end

      def uri_without_params
        @uri ||= URI(@url)
      end
      alias_method :uri, :uri_without_params
    end
  end
end
