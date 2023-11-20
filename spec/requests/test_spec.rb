# Write a simple test just to check that capybara and rspec are working as expected

# Path: spec/requests/test_spec.rb
require 'rails_helper'

RSpec.describe "Test", type: :request do
  it "should pass" do
    expect(true).to eq(true)
  end
end
