require 'test_helper'
require 'active_support/core_ext/object/to_query'

module Ogc
  class QueryTest < TestCase
    using Query

    setup do
      @hash  = { 'service' => 'wfs', 'srsname' => 'epsg:4326', 'version' => '1.0.0' }
      @query = @hash.to_query
    end

    def test_exceptions_module_is_defined
      assert_equal @hash, Hash.from_query(@query)
    end
  end
end
