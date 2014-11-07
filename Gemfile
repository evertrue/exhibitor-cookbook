source 'https://rubygems.org'

group :test do
  gem 'berkshelf',  '~> 3.1'
  gem 'foodcritic', '~> 4.0'
  gem 'rubocop',    '~> 0.26'
end

group :test, :integration do
  gem 'test-kitchen',
      github: 'test-kitchen/test-kitchen',
      tag: '459238b88ccb4219d8bcabd5a89a8adcb7391b16'
  gem 'kitchen-vagrant', '~> 0.15'
end
