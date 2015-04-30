# -*- encoding : utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$:.unshift lib unless $:.include? lib

require 'sekken/version'

Gem::Specification.new do |s|
  s.name        = 'sekken'
  s.version     = Sekken::VERSION
  s.authors     = ['Daniel Harrington', 'Tim Jarratt']
  s.email       = 'tjarratt@gmail.com'
  s.homepage    = 'http://savonrb.com'
  s.summary     = 'Next-Gen SOAP client'
  s.description = 'Sekken is an experimental SOAP client for the Ruby community.'
  s.required_ruby_version = '>= 1.9.3'

  s.rubyforge_project = s.name
  s.license = 'MIT'

  # TODO: get rid of Nori.
  s.add_dependency 'nori',     '~> 2.2.0'

  s.add_dependency 'nokogiri',   '>= 1.4.0'
  s.add_dependency 'builder',    '>= 3.0.0'
  s.add_dependency 'httpclient', '~> 2.3'
  s.add_dependency 'logging',    '~> 1.8'

  s.add_development_dependency 'rake',  '~> 10.1'
  s.add_development_dependency 'rspec', '~> 2.14'
  s.add_development_dependency 'mocha', '~> 0.14'
  s.add_development_dependency 'equivalent-xml', '~> 0.3'
  s.add_development_dependency "transpec"

  ignores  = File.readlines('.gitignore').grep(/\S+/).map(&:chomp)
  dotfiles = %w[.gitignore .travis.yml .yardopts]
  http_adapters = Dir['lib/sekken/http_adapter/*']

  unexcluded_files = Dir['**/*'].reject { |f|
    File.directory?(f) || ignores.any? { |i| File.fnmatch(i, f) } || http_adapters.any? { |i| File.fnmatch(i, f) }
  }

  s.files = (unexcluded_files + dotfiles).sort

  s.require_path = 'lib'
end
