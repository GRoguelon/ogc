require 'test_helper'

class OgcTest < Minitest::Test
  def test_ogc_module_is_defined
    refute_nil ::Ogc
  end
end
