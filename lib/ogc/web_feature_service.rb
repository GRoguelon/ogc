require 'ogc/web_feature_service/base'
require 'ogc/web_feature_service/get_capabilities'
require 'ogc/web_feature_service/get_feature'

require 'active_support/core_ext/string/inflections'

module Ogc
  module WebFeatureService
    SUPPORTED_METHODS = %i( get_capabilities get_feature ).freeze

    class << self
      SUPPORTED_METHODS.each do |method|
        define_method(method) do |*args|
          "#{self}::#{method.to_s.camelize}".constantize.new(*args)
        end
      end
    end
  end
end
