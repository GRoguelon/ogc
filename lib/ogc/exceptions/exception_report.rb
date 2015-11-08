require 'ogc/exceptions/ogc_exception'

module Ogc
  module Exceptions
    class ExceptionReport < OgcException
      ROOTS = %w( ServiceExceptionReport ExceptionReport ).freeze

      attr_reader :report

      class << self
        def exception?(report)
          ROOTS.include?(report.root.name)
        end
      end

      def initialize(report)
        raise ArgumentError unless self.class.exception?(report)
        @report = report
        super(get_first_exception_message)
      end

      def at_xpath(xpath)
        @report.at_xpath(xpath)
      end

      def xpath(xpath)
        @report.xpath(xpath)
      end

      def version
        xpath = @report.at_xpath('/*/@version')
        xpath ? xpath.text : nil
      end

    private

      def get_first_exception_message
        message   = @report.at_xpath('//xmlns:ServiceException')
        message ||= @report.at_xpath('//xmlns:ExceptionText')
        message && message.content
      end
    end
  end
end
