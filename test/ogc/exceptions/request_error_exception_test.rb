require 'test_helper'

module Ogc
  module Exceptions
    class RequestErrorExceptionTest < TestCase
      test 'class inherits from OgcException' do
        assert RequestErrorException < OgcException
      end
    end
  end
end
