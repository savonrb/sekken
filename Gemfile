source 'https://rubygems.org'
gemspec name: 'sekken'
gemspec name: 'sekken-httpclient'

# profiling
#gem 'method_profiler', require: false
#gem 'ruby-prof',       require: false  # does not work on jruby!

# coverage
gem 'simplecov', require: false
gem 'coveralls', require: false

# dependencies
#gem 'rubydeps',  require: false  # uses c extensions

# debugging
#gem 'debugger',  require: false  # don't install on travis!

platform :rbx do
  gem 'json'
  gem 'racc'
  gem 'rubysl'
  gem 'rubinius-coverage'
end

group :development do
  gem 'fuubar'
end
