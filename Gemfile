# frozen_string_literal: true
ruby '2.6.6'

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Server requirements
gem 'thin'

# Project requirements
gem 'rake'
gem 'dotenv'
gem 'chronic'

# Component requirements
gem 'activerecord', '~> 5', require: 'active_record'
gem 'pg', '~> 0.18'

# Padrino Stable Gem
gem 'padrino', '0.14.3'

# AWS
gem 'aws-sdk-ec2', '~> 1'

# AuthN
gem 'omniauth'
gem 'omniauth-facebook'

gem 'rbnacl', '~> 7.1'
gem 'discordrb'

# Maintenance
gem 'sentry-raven'

group :development do
  gem 'byebug'
end
