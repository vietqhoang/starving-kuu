# frozen_string_literal: true

RSpec.describe StarvingKuu::Restaurant do
  let(:restaurant_data_path) { "spec/tmp/#{described_class::RESTAURANT_DATA_PATH}" }
  before { stub_const("#{described_class}::RESTAURANT_DATA_PATH", restaurant_data_path) }
  after(:each) { File.delete(restaurant_data_path) if File.exist?(restaurant_data_path) }

  describe '#restaurants' do
    context 'when the restaurant data file exists' do
      context 'and when the restaurant data is empty' do
        before { allow(YAML).to receive(:load_file).with(described_class::RESTAURANT_DATA_PATH).and_return(YAML.safe_load('')) }

        it 'returns an empty array' do
          expect(described_class.new.restaurants).to eq([])
        end
      end

      context 'and when the restaurant data has content' do
        let(:restaurants) { ['McDonalds', 'Burger King', 'Wendys', 'Chipotle'] }
        before { allow(YAML).to receive(:load_file).with(described_class::RESTAURANT_DATA_PATH).and_return(restaurants) }

        it 'returns the array of contents' do
          expect(described_class.new.restaurants).to contain_exactly(*restaurants)
        end
      end
    end

    context 'when the restaurant data file does not exist' do
      it 'returns an empty array' do
        expect(described_class.new.restaurants).to eq([])
      end

      it 'creates a restaurant data file' do
        described_class.new.restaurants

        expect(File.exist?(restaurant_data_path)).to eq(true)
      end
    end
  end

  describe '#sample' do
    let(:restaurants) { ['McDonalds', 'Burger King', 'Wendys', 'Chipotle'] }

    before { allow(YAML).to receive(:load_file).with(described_class::RESTAURANT_DATA_PATH).and_return(restaurants) }

    it 'returns a random restaurant' do
      expect(restaurants).to include(described_class.new.sample)
    end
  end
end
