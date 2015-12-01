require 'ogc/errors/ogc_error'

module Ogc
  module Errors
    class ServiceError < OgcError
      attr_reader :code

      def initialize(http_error)
        super(http_error.message)
        @code = http_error.code
      end
    end
  end
end
