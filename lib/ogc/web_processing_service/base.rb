require 'ogc/abstract_base'

module Ogc
  module WebProcessingService
    class Base < AbstractBase
      self.default_params = { 'service' => 'wps' }.freeze
    end
  end
end
