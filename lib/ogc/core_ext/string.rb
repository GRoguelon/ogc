require 'active_support/core_ext/string/filters'

class String
  def clean_xml!
    self.gsub!(/>\n+ *\t*</, '><')
    self.squish!
    self
  end
end
