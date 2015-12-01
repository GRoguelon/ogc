require 'test_helper'

module Ogc
  module Errors
    class OgcErrorTest < TestCase
      test 'class inherits from StandardError' do
        assert OgcError < StandardError
      end
    end
  end
end
