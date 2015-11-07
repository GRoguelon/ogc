module Ogc
  module WebFeatureService
    class GetCapabilities < Base
      def get(&block)
        super(request: self.class.request_name, &block)
      end
    end
  end
end
