require 'test_helper'

require 'active_support/core_ext/string/inflections'

module Ogc
  class WebFeatureServiceTest < TestCase
    URL         = 'http://localhost/wfs'
    PARAMS      = { 'version' => '1.0.0', 'key' => 'ABCDE' }

    test 'WebFeatureService module is defined' do
      refute_nil WebFeatureService
    end

    WebFeatureService::SUPPORTED_METHODS.each do |method|
      test "#{method} class method returns #{method.to_s.camelize} instance" do
        klass    = "#{WebFeatureService}::#{method.to_s.camelize}".constantize
        instance = WebFeatureService.send(method, URL, PARAMS)
        assert_instance_of klass, instance
      end
    end
  end
end
