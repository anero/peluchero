# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Server requirements
gem 'thin'

# Project requirements
gem 'rake'

# Component requirements
gem 'activerecord', '~> 4', require: 'active_record'
gem 'pg', '~> 0.18'

# Padrino Stable Gem
gem 'padrino', '0.14.3'

group :development do
  gem 'byebug'
end
