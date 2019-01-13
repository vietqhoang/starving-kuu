# frozen_string_literal: true

RSpec.describe StarvingKuu::RestaurantSelector do
  describe '#restaurants' do
    context 'when the restaurant data file exists' do
      context 'and when the restaurant data is empty' do
        before { allow(YAML).to receive(:load_file).with(described_class::RESTAURANT_DATA_ABSOLUTE_PATH).and_return(YAML.safe_load('')) }

        it 'returns an empty array' do
          expect(described_class.new.restaurants).to eq([])
        end
      end

      context 'and when the restaurant data has content' do
        let(:restaurants) { ['McDonalds', 'Burger King', 'Wendys', 'Chipotle'] }
        before { allow(YAML).to receive(:load_file).with(described_class::RESTAURANT_DATA_ABSOLUTE_PATH).and_return(restaurants) }

        it 'returns the array of contents' do
          expect(described_class.new.restaurants).to contain_exactly(*restaurants)
        end
      end
    end

    context 'when the restaurant data file does not exist' do
      before { allow(YAML).to receive(:load_file).with(described_class::RESTAURANT_DATA_ABSOLUTE_PATH).and_raise(Errno::ENOENT) }

      it 'returns an empty array' do
        expect(described_class.new.restaurants).to eq([])
      end

      it 'creates a restaurant data file' do
        expect(File).to receive(:open).with(described_class::RESTAURANT_DATA_ABSOLUTE_PATH, 'a')

        described_class.new.restaurants
      end
    end
  end

  describe '#sample_restaurant' do
    let(:restaurants) { ['McDonalds', 'Burger King', 'Wendys', 'Chipotle'] }

    before { allow(YAML).to receive(:load_file).with(described_class::RESTAURANT_DATA_ABSOLUTE_PATH).and_return(restaurants) }

    it 'returns a random restaurant' do
      expect(restaurants).to include(described_class.new.sample_restaurant)
    end
  end
end
