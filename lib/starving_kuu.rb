Dir['lib/starving_kuu/*.rb'].each { |file| require_relative(file.delete_prefix('lib/')) }

module StarvingKuu; end
