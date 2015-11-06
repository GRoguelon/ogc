require 'test_helper'

module Ogc
  module Exceptions
    class ExceptionReportTest < TestCase
      using CleanXML

      setup do
        @xml_100    = read_xml('wfs/service_exception_report')
        @report_100 = ExceptionReport.new(@xml_100)

        @xml_110    = read_xml('wfs/exception_report')
        @report_110 = ExceptionReport.new(@xml_110)

        @xml_fake = read_xml('wfs/fake_report')
      end

      test 'class inherits from OgcException' do
        assert ExceptionReport < OgcException
      end

      test 'ROOTS constant is a frozen array of string' do
        assert ExceptionReport::ROOTS.frozen?
        assert_kind_of Array, ExceptionReport::ROOTS
      end

      test 'is_exception? class method return boolean' do
        assert ExceptionReport.is_exception?(@xml_100)
        refute ExceptionReport.is_exception?(@xml_fake)
      end

      test 'constructor takes xml and sets the attribute' do
        assert_equal @xml_100.to_xml, @report_100.report.to_xml
        assert_equal @xml_110.to_xml, @report_110.report.to_xml
      end

      test 'constructor raises ArgumentError is not an WFS exception' do
        assert_raises(ArgumentError) { ExceptionReport.new(@xml_fake) }
      end

      test 'constructor sets the message of StandardError attribute' do
        msg = 'Unable to INSERT STMT'
        assert_equal msg, @report_100.message

        msg = 'parse error: missing closing tag for element wkbGeom'
        assert_equal msg, @report_110.message
      end

      test 'at_xpath method delegates to report instance variable' do
        assert_equal '1.2.0', @report_100.at_xpath('/*/@version').text
        assert_equal '1.1.0', @report_110.at_xpath('/*/@version').text
      end

      test 'xpath method delegates to report instance variable' do
        expected_xml  = %{<ServiceException code="999" locator="INSERT STMT 01">}
        expected_xml += %{Unable to INSERT STMT}
        expected_xml += %{</ServiceException>}
        actual_xml    = @report_100.xpath('//xmlns:ServiceException').first.to_xml
        assert_equal expected_xml, actual_xml

        expected_xml  = %{<ExceptionText>}
        expected_xml += %{parse error: missing closing tag for element wkbGeom}
        expected_xml += %{</ExceptionText>}
        actual_xml    = @report_110.xpath('//xmlns:ExceptionText').first.to_xml
        assert_equal expected_xml, actual_xml
      end

      test 'version method returns version attribute' do
        assert_equal '1.2.0', @report_100.version
        assert_equal '1.1.0', @report_110.version
      end
    end
  end
end
