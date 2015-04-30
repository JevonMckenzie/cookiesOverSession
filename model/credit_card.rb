require 'json'
require 'openssl'
require 'sinatra/activerecord'
require_relative '../environments.rb'
require_relative '../lib/luhn_validator.rb'

# Credit card entity
class CreditCard < ActiveRecord::Base
  # Mixin the validator
  include LuhnValidator

  # instance variables with automatic getter/setter methods
  # attr_accessor :number, :expiration_date, :owner, :credit_network
  #
  # def initialize(number, expiration_date, owner, credit_network)
  #   @number = number
  #   @expiration_date = expiration_date
  #   @owner = owner
  #   @credit_network = credit_network
  # end

  # returns json string
  def to_json
    {
      number: @number,
      expiration_date: @expiration_date,
      owner: @owner,
      credit_network: @credit_network
    }.to_json
  end

  # returns all card information as single string
  def to_s
    to_json
  end

  # return a new CreditCard object given a serialized (JSON) representation
  def self.from_s(card_s)
    card = JSON.parse(card_s)
    CreditCard.new(card['number'], card['expiration_date'],
                   card['owner'], card['credit_network'])
  end

  # return a hash of the serialized credit card object
  def hash
    to_json.hash
  end

  # return a cryptographically secure hash
  def hash_secure
    OpenSSL::Digest::SHA256.new.digest(to_json).unpack('H*').first
  end

  # number getter
  def number
    # please decrypt the number and return
  end

  # number setter
  def number=(plain_number)
    # please encrypt the number
  end
end
