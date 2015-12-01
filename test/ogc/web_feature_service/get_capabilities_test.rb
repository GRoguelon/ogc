require 'test_helper'

module Ogc
  module WebFeatureService
    class GetCapabilitiesTest < TestCase
      URL         = 'http://localhost/wfs'
      PARAMS      = { 'version' => '1.0.0', 'key' => 'ABCDE' }
      FULL_PARAMS = PARAMS.merge(Base::DEFAULT_PARAMS)

      setup do
        @base = GetCapabilities.new(URL, PARAMS)

        # XML files
        @response = read_file('wfs/get_capabilities_response')

        query = FULL_PARAMS.merge(request: GetCapabilities.request_name).to_query

        # Get method returns xml response:
        stub_request(:get, "#{URL}?#{query}").to_return(body: @response)
      end

      test 'class inherits from Base' do
        assert GetCapabilities < Base
      end

      test 'get method returns xml response' do
        xml = Nokogiri::XML(@response.clean_xml!).to_xml
        assert_equal xml, @base.get.to_xml
      end
    end
  end
end
