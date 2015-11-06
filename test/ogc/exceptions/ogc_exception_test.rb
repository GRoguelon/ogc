require 'test_helper'

module Ogc
  module Exceptions
    class OgcExceptionTest < TestCase
      test 'class inherits from StandardError' do
        assert OgcException < StandardError
      end
    end
  end
end
