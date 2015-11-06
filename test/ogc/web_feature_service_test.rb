require 'test_helper'

module Ogc
  class WebFeatureServiceTest < TestCase
    URL         = 'http://localhost/wfs'
    PARAMS      = { 'version' => '1.0.0', 'key' => 'ABCDE' }

    test 'WebFeatureService module is defined' do
      refute_nil WebFeatureService
    end

    test 'get_capabilities class method returns GetCapabilities instance' do
      capabilities = WebFeatureService.get_capabilities(URL, PARAMS)
      assert_instance_of WebFeatureService::GetCapabilities, capabilities
    end
  end
end
