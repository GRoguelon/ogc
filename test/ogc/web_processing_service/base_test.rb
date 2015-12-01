require 'test_helper'

module Ogc
  module WebProcessingService
    class BaseTest < TestCase
      test 'default_params class attribute is frozen' do
        assert_instance_of Hash, Base.default_params
        assert Base.default_params.frozen?
      end
    end
  end
end
