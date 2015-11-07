require 'test_helper'

module Ogc
  module WebFeatureService
    class GetFeatureTest < TestCase
      using CleanXML

      URL         = 'http://localhost/wfs'
      PARAMS      = { 'version' => '1.0.0', 'key' => 'ABCDE', typeName: :HYDROGRAPHY }
      FULL_PARAMS = PARAMS.merge(Base::DEFAULT_PARAMS)

      setup do
        @base = GetFeature.new(URL, PARAMS)

        # XML files
        @response  = read_file('wfs/get_feature_response')

        query = FULL_PARAMS.merge(request: GetFeature.request_name).to_query

        # Get method returns xml response:
        stub_request(:get, "#{URL}?#{query}").to_return(body: @response)
      end

      test 'class inherits from Base' do
        assert GetFeature < Base
      end

      test 'get method returns xml response' do
        xml = Nokogiri::XML(@response.clean_xml!).to_xml
        assert_equal xml, @base.get(:HYDROGRAPHY).to_xml
      end
    end
  end
end
