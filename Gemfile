source 'http://rubygems.org'

gem 'rails', '3.2.14'
gem 'pg',    '0.14.1'

gem 'rubyzip', :require => 'zip/zip'

group :assets do
  gem 'sass-rails',     '3.2.6'
  gem 'coffee-rails',   '3.2.2'
  gem 'uglifier'
  gem 'compass-rails',  '1.0.3'
end

gem 'jquery-rails', '2.2.1'

group :development do
  gem 'rvm-capistrano'
  gem 'thin'
  gem 'capistrano'
  gem 'annotate', :git => 'git@github.com:ctran/annotate_models.git', :require => false
end

group :test, :development do
  gem 'rspec-rails'
end

group :production do
  gem 'passenger'
  gem 'libv8',        '3.3.10.4'
  gem 'therubyracer', '0.10.2'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'pickle'
  gem 'minitest'
  gem 'capybara'
  gem 'turn', :require => false
  gem 'email_spec'
  gem 'launchy'
end

gem 'rgeo',                         '0.3.20'
gem 'rgeo-geojson',                 '0.2.3'
gem 'activerecord-postgis-adapter', '0.5.1'

gem 'kaminari',   '0.14.1'
gem 'devise',     '2.2.3'
gem 'cancan',     '1.6.9'
gem 'haml',       '3.1.8'
gem 'haml-rails', '0.3.5'

gem 'formtastic', '2.2.1'
gem 'pg_search',  '0.5.7'

gem "paperclip", "~> 2.0"
