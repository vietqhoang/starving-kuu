# frozen_string_literal: true

require 'yaml'

module StarvingKuu
  # Responsible for restaurant data and operations
  class Restaurant
    RESTAURANT_DATA_ABSOLUTE_PATH = '_data/restaurants.yml'

    attr_accessor :restaurants

    def initialize
      @restaurants = restaurant_data
    end

    def sample
      @restaurants.sample
    end

    private

    def validate_restaurants
      raise StarvingKuu::Error::Validation, 'restaurants must be an Array' unless @restaurants.is_a?(Array)

      @restaurants.each { |restaurant| validate_restaurant(restaurant) }
    end

    def validate_restaurant(restaurant)
      raise StarvingKuu::Error::Validation, 'restaurant must be a String' unless restaurant.is_a?(String)
    end

    def restaurant_data
      load_restaurant_data
    rescue Errno::ENOENT => e
      raise unless e.message.include?('No such file or directory')

      write_restaurant_data_file(default_restaurant_data)
      default_restaurant_data
    end

    def load_restaurant_data
      YAML.load_file(RESTAURANT_DATA_ABSOLUTE_PATH) || default_restaurant_data
    end

    def write_restaurant_data_file(data)
      File.open(RESTAURANT_DATA_ABSOLUTE_PATH, 'a') { |f| f.write(data.to_yaml) }
    end

    def default_restaurant_data
      []
    end
  end
end
