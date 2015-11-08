# Ogc
[![Build Status](https://travis-ci.org/GRoguelon/ogc.svg?branch=master)](https://travis-ci.org/GRoguelon/ogc)
[![Code Climate](https://codeclimate.com/github/GRoguelon/ogc/badges/gpa.svg)](https://codeclimate.com/github/GRoguelon/ogc)
[![GitHub version](https://badge.fury.io/gh/groguelon%2Fogc.svg)](https://badge.fury.io/gh/groguelon%2Fogc)

This gems allow you to make calls in using WFS or WPS protocol defined by OGC organization.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ogc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ogc

## Usage

Currently the gem OGC handles only some Web Feature Service calls.

To use it, you have two ways.

Either, you use the shortcut method of `WebFeatureService`module:

```ruby
# GetCapabilities
Ogc::WebFeatureService.get_capabilities('http://localhost/wfs', version: '1.0.0', key: 'SECRET')
#=> #<Ogc::WebFeatureService::GetCapabilities:0x007ffba414adc8 @url="http://localhost/wfs", @params={"version"=>"1.0.0", "key"=>"SECRET", "service"=>"wfs"}>

# GetFeature
Ogc::WebFeatureService.get_feature('http://localhost/wfs', version: '1.0.0', key: 'SECRET')
#=> #<Ogc::WebFeatureService::GetFeature:0x007ffba41ad720 @url="http://localhost/wfs", @params={"version"=>"1.0.0", "key"=>"SECRET", "service"=>"wfs"}>
```

Or use the class directly:

```ruby
# GetCapabilities
Ogc::WebFeatureService::GetCapabilies.new('http://localhost/wfs', version: '1.0.0', key: 'SECRET')
#=> #<Ogc::WebFeatureService::GetCapabilities:0x007ffba414adc8 @url="http://localhost/wfs", @params={"version"=>"1.0.0", "key"=>"SECRET", "service"=>"wfs"}>

# GetFeature
Ogc::WebFeatureService::GetFeature.new('http://localhost/wfs', version: '1.0.0', key: 'SECRET')
#=> #<Ogc::WebFeatureService::GetFeature:0x007ffba41ad720 @url="http://localhost/wfs", @params={"version"=>"1.0.0", "key"=>"SECRET", "service"=>"wfs"}>
```

After that, you can use the methods `#get` and `#post` to resquest the endpoint.

```ruby
ogc = Ogc::WebFeatureService::GetFeature.new('http://localhost/wfs', version: '1.0.0', key: 'SECRET')
ogc.get(:FEATURE_1, filter '…')
#=> Nokogiri::XML::Document
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ogc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

