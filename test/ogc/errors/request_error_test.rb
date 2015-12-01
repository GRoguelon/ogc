require 'test_helper'

module Ogc
  module Errors
    class RequestErrorTest < TestCase
      test 'class inherits from OgcError' do
        assert RequestError < OgcError
      end
    end
  end
end
