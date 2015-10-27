require 'test_helper'

module Ogc
  class VersionTest < Minitest::Test
    SEMANTIV_VERSION_REGEX = /\A\d+\.\d+\.\d+(\.[a-z0-9]+)?\z/

    def test_ogc_version_is_defined
      assert_kind_of String, VERSION
    end

    def test_ogc_version_respects_semantic_versions
      assert_match SEMANTIV_VERSION_REGEX, VERSION
    end
  end
end
