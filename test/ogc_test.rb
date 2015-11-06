require 'test_helper'

class OgcTest < Ogc::TestCase
  test 'ogc module is defined' do
    refute_nil ::Ogc
  end
end
