# frozen_string_literal: true
ruby '2.6.3'

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Server requirements
gem 'thin'

# Project requirements
gem 'rake'
gem 'dotenv'
gem 'chronic'

# Component requirements
gem 'activerecord', '~> 4', require: 'active_record'
gem 'pg', '~> 0.18'

# Padrino Stable Gem
gem 'padrino', '0.14.3'

# AWS
gem 'aws-sdk-ec2', '~> 1'
gem 'aws-sdk-iam', '~> 1'

# AuthN
gem 'omniauth'
gem 'omniauth-facebook'

# Maintenance
gem 'sentry-raven'

group :development do
  gem 'byebug'
end
