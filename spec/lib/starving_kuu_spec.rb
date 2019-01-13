require File.expand_path('../../lib/starving_kuu.rb', File.dirname(__FILE__))

RSpec.describe StarvingKuu do
  let(:dummy_class) { Class.new { include StarvingKuu } }
end
