# frozen_string_literal: true

require 'yaml'

module StarvingKuu
  # Responsible for randomly selecting a restaurant
  class RestaurantSelector
    RESTAURANT_DATA_ABSOLUTE_PATH = '_data/restaurants.yml'.freeze

    def initialize
      @restaurants = YAML.load_file(RESTAURANT_DATA_ABSOLUTE_PATH)
    end

    def sample_restaurant
      @restaurants.sample
    end
  end
end
