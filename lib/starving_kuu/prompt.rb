# frozen_string_literal: true

require 'tty-prompt'

module StarvingKuu
  # Responsible for handling user prompts
  class Prompt
    def start
      main_menu
    end

    private

    def main_menu
      case main_menu_prompt
      when :sample_restaurant
        sample_restaurant_message
      when :exit
        exit_message
      end
    end

    def main_menu_prompt
      prompt.select('What would you like to do?') do |menu|
        menu.choice name: 'Give me a random restaurant', value: :sample_restaurant
        menu.choice name: 'Exit', value: :exit
      end
    end

    def exit_message
      puts %(

        Starving Kuu says good bye!

      )
    end

    def sample_restaurant_message
      puts %(

        Starving Kuu chooses...

        #{highlight_result(restaurant_selector.sample_restaurant)}

      )
    end

    def highlight_result(result)
      stylize.decorate(result, :bold, :green, :on_black)
    end

    def restaurant_selector
      StarvingKuu::RestaurantSelector.new
    end

    def prompt
      TTY::Prompt.new
    end

    def stylize
      Pastel.new
    end
  end
end
