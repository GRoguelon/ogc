$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'ogc'

require 'nokogiri'

require 'webmock/minitest'
require 'minitest/pride'
require 'minitest/autorun'

module Ogc
  class TestCase < Minitest::Test
    using CleanXML

    class << self
      def setup(&block)
        define_method(:setup, &block)
      end

      def teardown(&block)
        define_method(:teardown, &block)
      end

      def test(name, &block)
        test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
        defined = method_defined? test_name
        raise "#{test_name} is already defined in #{self}" if defined
        if block_given?
          define_method(test_name, &block)
        else
          define_method(test_name) do
            flunk "No implementation provided for #{name}"
          end
        end
      end
    end

    def assert_nothing_raised(*args)
      yield
    end

    def read_file(name)
      File.read(File.join('test/xml', "#{name}.xml"))
    end

    def read_xml(name, clean = true)
      file = read_file(name)
      Nokogiri::XML(clean ? file.clean_xml! : file)
    end
  end
end
