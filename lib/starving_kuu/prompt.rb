# frozen_string_literal: true

require 'tty-prompt'

module StarvingKuu
  # Responsible for handling user prompts
  class Prompt
    def initialize
      @prompt_instance = TTY::Prompt.new
      @restaurant_instance = StarvingKuu::Restaurant.new
      @stylize_instance = Pastel.new
    end

    def start
      main_screen
    end

    private

    def add_restaurant_screen
      template_screen do
        @restaurant_instance.restaurants << @prompt_instance.ask('What is the name of the restaurant?')
        @restaurant_instance.save
      end
    end

    def main_screen
      template_screen
    end

    def sample_restaurant_screen
      template_screen { sample_restaurant_message }
    end

    def template_screen
      yield if block_given?
      send(main_menu_prompt)
    end

    def exit
      exit_message
    end

    def main_menu_prompt
      @prompt_instance.select('What would you like to do?', main_menu_options)
    end

    def main_menu_options
      [
        { name: 'Give me a random restaurant', value: :sample_restaurant_screen, disabled: disable_restaurant_reason },
        { name: 'Add restaurant', value: :add_restaurant_screen },
        { name: 'Exit', value: :exit }
      ]
    end

    def disable_restaurant_reason
      "(#{@restaurant_instance.restaurants.length} items)" if @restaurant_instance.restaurants.length.zero?
    end

    def exit_message
      puts %(

        Starving Kuu says good bye!

      )
    end

    def sample_restaurant_message
      puts %(

        Starving Kuu chooses...

        #{highlight_result(@restaurant_instance.restaurants.sample)}

      )
    end

    def highlight_result(result)
      @stylize_instance.decorate(result, :bold, :green, :on_black)
    end
  end
end
