source 'https://rubygems.org'
ruby "2.3.1"

gem 'rails', '~> 5.0.1'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'simple_form', '~> 3.4'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'devise', '~> 4.2'

gem 'paperclip', '~> 5.1'
gem 'aws-sdk', '~> 2.3'

gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 5.0.5'
gem 'turbolinks', '~> 5'
#gem 'jbuilder', '~> 2.5'
gem 'bcrypt', git: 'https://github.com/codahale/bcrypt-ruby.git', :require => 'bcrypt'
gem 'activeadmin', '~> 1.0.0.pre4'
gem 'inherited_resources', git: 'https://github.com/activeadmin/inherited_resources'
gem 'redis', '~> 3.2' # Needed for sockets.
gem 'resque', "~> 1.22.0"


group :development, :test do
  gem 'thin'
  gem 'byebug', platform: :mri
  gem 'sqlite3'
end

group :development do
  gem 'web-console', '>= 3.3.0'
end

group :production do
	gem 'pg'
  gem 'puma', '~> 3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


gem "nested_form"
