# frozen_string_literal: true

require 'tty-prompt'

module StarvingKuu
  # Responsible for handling user prompts
  class Prompt
    def start
      main_screen
    end

    private

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
      prompt.select('What would you like to do?', main_menu_options)
    end

    def main_menu_options
      disable_restaurant_reason = "(#{restaurants.restaurants.length} items)" if restaurants.restaurants.length.zero?

      [
        { name: 'Give me a random restaurant', value: :sample_restaurant_screen, disabled: disable_restaurant_reason },
        { name: 'Exit', value: :exit }
      ]
    end

    def exit_message
      puts %(

        Starving Kuu says good bye!

      )
    end

    def sample_restaurant_message
      puts %(

        Starving Kuu chooses...

        #{highlight_result(restaurants.sample)}

      )
    end

    def highlight_result(result)
      stylize.decorate(result, :bold, :green, :on_black)
    end

    def restaurants
      StarvingKuu::Restaurant.new
    end

    def prompt
      TTY::Prompt.new
    end

    def stylize
      Pastel.new
    end
  end
end
