require 'rails_helper'

RSpec.describe City, type: :model do
  before do
    @city = City.first
  end

  it "should create find a city" do
    p "++AAAAAAAAAAA" 
    p @city
    p "--AAAAAAAAAAA"
  end
end
