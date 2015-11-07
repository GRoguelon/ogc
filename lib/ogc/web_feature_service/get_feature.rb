module Ogc
  module WebFeatureService
    class GetFeature < Base
      def get(type_name, extra_params = Hash.new, &block)
        params = {
          :request  => self.class.request_name,
          :typeName => type_name
        }.merge!(extra_params)

        super(params, &block)
      end
    end
  end
end
