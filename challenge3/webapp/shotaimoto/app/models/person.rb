# require 'active_model'
class Person < ApplicationRecord
  include ActiveModel::Model

  attr_accessor :name, :age
end
