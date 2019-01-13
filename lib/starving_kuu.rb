# frozen_string_literal: true

run_prompt = ARGV.include?('prompt')

Dir['lib/starving_kuu/*.rb'].each { |file| require_relative(file.delete_prefix('lib/')) }

module StarvingKuu; end

StarvingKuu::Prompt.new.start if run_prompt
