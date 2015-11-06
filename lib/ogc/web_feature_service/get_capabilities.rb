module Ogc
  module WebFeatureService
    class GetCapabilities < Base
      REQUEST = :GetCapabilities

      def get(&block)
        super(request: REQUEST, &block)
      end
    end
  end
end
