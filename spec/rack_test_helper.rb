ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'

require 'dotenv'
Dotenv.load
