# frozen_string_literal: true

module Fixtures
  module RestaurantHelpers
    def restaurants
      [
        "McDonalds",
        "Burger King",
        "Wendys",
        "Chipotle"
      ]
    end
  end
end

RSpec.configure do |config|
  config.include Fixtures::RestaurantHelpers

  config.before(:each) do
    allow(YAML).to receive(:load_file).with(StarvingKuu::RestaurantSelector::RESTAURANT_DATA_ABSOLUTE_PATH).and_return(restaurants)
  end
end
