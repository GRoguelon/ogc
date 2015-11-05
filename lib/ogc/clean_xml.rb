require 'active_support/core_ext/string/filters'

module Ogc
  module CleanXML
    refine String do
      def clean_xml!
        self.gsub!(/>\n+ *\t*</, '><')
        self.squish!
        self
      end
    end
  end
end
