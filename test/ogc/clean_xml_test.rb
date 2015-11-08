require 'test_helper'
require 'active_support/core_ext/string/strip'

module Ogc
  class CleanXMLTest < TestCase
    using CleanXML

    setup do
      @xml = <<-XML.strip_heredoc
        <class name="FakeClass"
               extends="Object">
          <methods>
            <class-method name="clean" arity="1">
              <arguements>
                <argument name="xml" />
              </arguments>
          </methods>
        </class>
      XML

      @cleaned_xml  = '<class name="FakeClass" extends="Object"><methods>'
      @cleaned_xml += '<class-method name="clean" arity="1">'
      @cleaned_xml += '<arguements><argument name="xml" /></arguments>'
      @cleaned_xml += '</methods></class>'
    end

    test 'clean_xml! method remove the breaklines' do
      assert_equal @cleaned_xml, @xml.clean_xml!
    end
  end
end
