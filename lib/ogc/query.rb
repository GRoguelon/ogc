require 'uri'

module Ogc
  module Query
    refine Hash.singleton_class do
      def from_query(query)
        Hash[URI.decode_www_form(query.to_s)]
      end
    end
  end
end
