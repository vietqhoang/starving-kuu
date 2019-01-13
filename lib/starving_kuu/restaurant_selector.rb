# frozen_string_literal: true

require 'yaml'

module StarvingKuu
  # Responsible for randomly selecting a restaurant
  class RestaurantSelector
    RESTAURANT_DATA_ABSOLUTE_PATH = '_data/restaurants.yml'

    attr_accessor :restaurants

    def initialize
      @restaurants = restaurant_data
    end

    def sample_restaurant
      @restaurants.sample
    end

    private

    def restaurant_data
      load_restaurant_data
    rescue Errno::ENOENT => e
      raise unless e.message.include?('No such file or directory')

      create_restaurant_data_file
      default_restaurant_data
    end

    def load_restaurant_data
      YAML.load_file(RESTAURANT_DATA_ABSOLUTE_PATH) || default_restaurant_data
    end

    def create_restaurant_data_file
      File.open(RESTAURANT_DATA_ABSOLUTE_PATH, 'a') { |f| f.write(default_restaurant_data.to_yaml) }
    end

    def default_restaurant_data
      []
    end
  end
end
