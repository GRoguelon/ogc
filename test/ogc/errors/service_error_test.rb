require 'test_helper'
require 'minitest/mock'

module Ogc
  module Errors
    class ServiceErrorTest < TestCase
      setup do
        @mock = Minitest::Mock.new
        @mock.expect :code, 666
        @mock.expect :message, 'Hello Wolrd'
      end

      test 'class inherits from OgcError' do
        assert ServiceError < OgcError
      end

      test 'constructor takes a HTTP error' do
        ex = ServiceError.new(@mock)
        assert 666, ex.code
        assert 'Hello World', ex.message
        @mock.verify
      end
    end
  end
end
