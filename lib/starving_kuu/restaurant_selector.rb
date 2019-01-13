# frozen_string_literal: true

require 'yaml'

module StarvingKuu
  class RestaurantSelector
    RESTAURANT_DATA_ABSOLUTE_PATH = File.expand_path('../../_data/restaurants.yml', File.dirname(__FILE__)).freeze

    def initialize
      @restaurants = YAML.load_file(RESTAURANT_DATA_ABSOLUTE_PATH)
    end

    def sample_restaurant
      @restaurants.sample
    end
  end
end
