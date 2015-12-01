require 'ogc/abstract_base'

require 'active_support/core_ext/module/introspection'

module Ogc
  module WebFeatureService
    class Base < AbstractBase
      self.default_params = { 'service' => 'wfs' }.freeze
    end
  end
end
