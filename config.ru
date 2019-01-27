#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

require File.expand_path("../config/boot.rb", __FILE__)

# Sentry setup
require 'raven'
Raven.configure do |config|
  config.dsn = ENV['SENTRY_DSN']
end
use Raven::Rack

run Padrino.application
