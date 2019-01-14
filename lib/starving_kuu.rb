# frozen_string_literal: true

Dir['lib/starving_kuu/**/*.rb'].each { |file| require_relative File.join('..', file) }

# This is the top namespace module for the application
module StarvingKuu; end

run_prompt = ARGV.include?('prompt')

StarvingKuu::Prompt.new.start if run_prompt
