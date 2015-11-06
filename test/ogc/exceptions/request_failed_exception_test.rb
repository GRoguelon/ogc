require 'test_helper'
require 'minitest/mock'

module Ogc
  module Exceptions
    class RequestFailedExceptionTest < TestCase
      setup do
        @mock = Minitest::Mock.new
        @mock.expect :code, 666
        @mock.expect :message, 'Hello Wolrd'
      end

      test 'class inherits from OgcException' do
        assert RequestFailedException < OgcException
      end

      test 'constructor takes a HTTP error' do
        ex = RequestFailedException.new(@mock)
        assert 666, ex.code
        assert 'Hello World', ex.message
        @mock.verify
      end
    end
  end
end
