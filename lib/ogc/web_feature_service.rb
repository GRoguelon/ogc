require 'ogc/web_feature_service/base'
require 'ogc/web_feature_service/get_capabilities'

module Ogc
  module WebFeatureService
    class << self
      def get_capabilities(*args)
        GetCapabilities.new(*args)
      end
    end
  end
end
