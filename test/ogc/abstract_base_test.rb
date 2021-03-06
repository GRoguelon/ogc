require 'test_helper'

module Ogc
  class AbstractBaseTest < TestCase
    include Errors

    URL    = 'http://localhost/wfs'
    PARAMS = { 'version' => '1.0.0', 'key' => 'ABCDE' }

    # Fake exception
    CalledBlockException = Class.new(StandardError)

    setup do
      @base = AbstractBase.new(URL, PARAMS)

      # XML files
      @request   = read_file('wfs/get_capabilities_request')
      @response  = read_file('wfs/get_capabilities_response')
      @exception = read_file('wfs/exception_report')

      query = PARAMS.merge(request: :hello).to_query

      # Get method returns xml response:
      stub_request(:get, "#{URL}?#{query}").to_return(body: @response)

      # Get method returns xml exception:
      stub_request(:get, "#{URL}?ex=xml&#{query}")
        .to_return(body: @exception)

      # Get method returns Timeout exception:
      stub_request(:get, "#{URL}?ex=timeout&#{query}")
        .to_raise(Timeout::Error)

      # Get method returns NotFound return:
      stub_request(:get, "#{URL}?ex=notFound&#{query}")
        .to_return(status: [404, 'Not Found'])

      # Post method returns xml response:
      stub_request(:post, "#{URL}").with(body: @request)
        .to_return(body: @response)
    end

    test 'request_name class method returns the name of the class' do
      assert_equal 'AbstractBase', AbstractBase.request_name
      assert_same AbstractBase.request_name, AbstractBase.request_name

      FakeService = Class.new(AbstractBase)
      assert_equal 'FakeService', FakeService.request_name
    end

    test 'constructor takes an url and some params as arguments' do
      assert_equal URL, @base.url
      refute_same PARAMS, @base.params
      assert_equal PARAMS, @base.params
    end

    test 'constructor stringifies the keys of params' do
      base = AbstractBase.new(URL, PARAMS.symbolize_keys)
      assert_equal PARAMS, base.params
    end

    test 'http method exposes the http object' do
      assert_instance_of Net::HTTP, @base.http
    end

    test 'get method returns xml response' do
      xml = Nokogiri::XML(@response.clean_xml!).to_xml
      assert_equal xml, @base.get(request: 'hello').to_xml
    end

    test 'get method takes a block to overload the request' do
      assert_raises CalledBlockException do
        @base.get(request: 'hello') do |_|
          raise CalledBlockException
        end
      end
    end

    test 'get method takes a block which exposes the request' do
      @base.get(request: :hello) do |request|
        assert_instance_of Net::HTTP::Get, request
      end
    end

    test 'post method returns xml response' do
      xml = Nokogiri::XML(@response.clean_xml!).to_xml
      assert_equal xml, @base.post(@request).to_xml
    end

    test 'post method takes a block to overload the request' do
      assert_raises CalledBlockException do
        @base.post(@request) do |_|
          raise CalledBlockException
        end
      end
    end

    test 'post method takes a block which exposes the request' do
      @base.post(@request) do |request|
        assert_instance_of Net::HTTP::Post, request
      end
    end

    test 'exception is raised if WFS returns exception' do
      assert_raises ExceptionReport do
        @base.get(request: :hello, ex: :xml)
      end
    end

    test 'exception is raised if Timeout is raised' do
      assert_raises RequestError do
        @base.get(request: :hello, ex: :timeout)
      end
    end

    test 'exception raised has a cause' do
      begin
        @base.get(request: :hello, ex: :timeout)
        assert false # In case where the exception is not raised.
      rescue RequestError => ex
        assert_instance_of Timeout::Error, ex.cause
      end
    end

    test 'request error raises ServiceError exception' do
      assert_raises ServiceError do
        @base.get(request: :hello, ex: :notFound)
      end
    end

    test 'response is cached' do
      assert_nil @base.response
      @base.get(request: 'hello')
      refute_nil @base.response
    end
  end
end
