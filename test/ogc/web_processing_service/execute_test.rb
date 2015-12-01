require 'test_helper'

module Ogc
  module WebProcessingService
    class ExecuteTest < TestCase
      URL    = 'http://localhost/wfs'
      PARAMS = {
        'version'    => '1.0.0',
        'key'        => 'ABCDE',
        'identifier' => 'HYDROGRAPHY'
      }
      FULL_PARAMS = PARAMS.merge(Base.default_params)

      setup do
        @base = Execute.new(URL, PARAMS)

        # XML files
        @response = read_file('wps/execute_response')

        query = FULL_PARAMS.merge(request: Execute.request_name).to_query

        # Get method returns xml response:
        stub_request(:get, "#{URL}?#{query}").to_return(body: @response)
      end

      test 'class inherits from Base' do
        assert Execute < Base
      end

      test 'get method returns xml response' do
        xml = Nokogiri::XML(@response.clean_xml!).to_xml
        assert_equal xml, @base.get(:HYDROGRAPHY).to_xml
      end
    end
  end
end
