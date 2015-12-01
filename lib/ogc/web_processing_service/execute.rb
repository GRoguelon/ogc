require 'ogc/web_processing_service/base'

module Ogc
  module WebProcessingService
    class Execute < Base
      def get(type_name, extra_params = {}, &block)
        params = {
          'request'  => self.class.request_name,
          'identifier' => type_name
        }.merge!(extra_params)

        super(params, &block)
      end
    end
  end
end
