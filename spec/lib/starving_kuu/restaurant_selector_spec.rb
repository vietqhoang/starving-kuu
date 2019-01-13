# frozen_string_literal: true

RSpec.describe StarvingKuu::RestaurantSelector do
  describe '#sample_restaurant' do
    it 'returns a random restaurant' do
      expect(restaurants).to include(described_class.new.sample_restaurant)
    end
  end
end
