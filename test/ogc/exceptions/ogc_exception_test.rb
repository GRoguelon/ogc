require 'test_helper'

module Ogc
  module Exceptions
    class OgcExceptionTest < TestCase
      test 'OgcException inherits from StandardError' do
        assert OgcException < StandardError
      end
    end
  end
end
