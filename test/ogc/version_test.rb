require 'test_helper'

module Ogc
  class VersionTest < TestCase
    SEMANTIV_VERSION_REGEX = /\A\d+\.\d+\.\d+(\.[a-z0-9]+)?\z/

    test 'ogc version is defined' do
      assert_kind_of String, VERSION
    end

    test 'ogc version respects semantic versions' do
      assert_match SEMANTIV_VERSION_REGEX, VERSION
    end
  end
end
