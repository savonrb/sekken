source 'https://rubygems.org'
gemspec

# profiling
#gem 'method_profiler', require: false
#gem 'ruby-prof',       require: false  # does not work on jruby!

# coverage
gem 'simplecov', require: false
gem 'coveralls', require: false

if RUBY_VERSION > "3"
  # FIXME: net-smtp, net-pop and net-imap was removed from ruby standard gems. Remove when https://github.com/mikel/mail/pull/1439 is resolved
  # Also see: https://github.com/rails/rails/pull/42366
  gem "net-smtp", require: false
  gem "net-pop", require: false
  gem "net-imap", require: false
  gem "rexml"
end

# dependencies
#gem 'rubydeps',  require: false  # uses c extensions

# debugging
#gem 'debugger',  require: false

group :development do
  gem 'fuubar'
end
