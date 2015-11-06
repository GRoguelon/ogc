module Ogc
  module Exceptions
    class RequestFailedException < OgcException
      attr_reader :code

      def initialize(http_error)
        super(http_error.message)
        @code = http_error.code
      end
    end
  end
end
