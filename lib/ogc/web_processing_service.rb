require 'ogc/web_processing_service/base'
require 'ogc/web_processing_service/execute'

require 'active_support/core_ext/string/inflections'

module Ogc
  module WebProcessingService
    SUPPORTED_METHODS = %i( execute ).freeze

    class << self
      def execute(*args)
        Execute.new(*args)
      end
    end
  end
end
