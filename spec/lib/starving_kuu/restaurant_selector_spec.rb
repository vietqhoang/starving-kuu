require File.expand_path('../../../lib/starving_kuu.rb', File.dirname(__FILE__))

RSpec.describe StarvingKuu::RestaurantSelector do
  let(:restaurants) { YAML.load_file(File.expand_path('../../fixtures/files/restaurants.yml', File.dirname(__FILE__))) }

  before do
    allow(YAML).to receive(:load_file).with(restaurant_data_absolute_path).and_return(restaurants)
  end

  describe '#sample_restaurant' do
    it 'returns a random restaurant' do
      expect(restaurants).to include(described_class.new.sample_restaurant)
    end
  end

  private

  def restaurant_data_absolute_path
    described_class::RESTAURANT_DATA_ABSOLUTE_PATH
  end
end
