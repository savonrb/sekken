# -*- encoding : utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$:.unshift lib unless $:.include? lib

require 'sekken/version'

Gem::Specification.new do |s|
  s.name        = 'sekken-httpclient'
  s.version     = Sekken::VERSION
  s.authors     = ['Daniel Harrington', 'Tim Jarratt']
  s.email       = 'tjarratt@gmail.com'
  s.homepage    = 'http://savonrb.com'
  s.summary     = 'HTTPClient adapter for Sekken'
  s.description = 'Sekken is an experimental SOAP client for the Ruby community. This is the standard HTTP adapter.'
  s.required_ruby_version = '>= 1.9.3'

  s.rubyforge_project = s.name
  s.license = 'MIT'

  s.add_dependency 'httpclient', '~> 2.3'
  s.add_dependency 'sekken', "~> #{Sekken::VERSION}"

  s.files = Dir['lib/sekken/http_adapter/httpclient*']

  s.require_path = 'lib'
end
