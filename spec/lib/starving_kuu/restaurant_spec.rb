# frozen_string_literal: true

RSpec.describe StarvingKuu::Restaurant do
  let(:described_instance) { described_class.new }
  let(:restaurant_data_path) { "spec/tmp/#{described_class::RESTAURANT_DATA_PATH}" }
  before { stub_const("#{described_class}::RESTAURANT_DATA_PATH", restaurant_data_path) }
  after(:each) { File.delete(restaurant_data_path) if File.exist?(restaurant_data_path) }

  describe '#restaurants' do
    context 'when the restaurant data file exists' do
      context 'and when the restaurant data is empty' do
        before { allow(YAML).to receive(:load_file).with(described_class::RESTAURANT_DATA_PATH).and_return(YAML.safe_load('')) }

        it 'returns an empty array' do
          expect(described_instance.restaurants).to eq([])
        end
      end

      context 'and when the restaurant data has content' do
        let(:restaurants) { ['McDonalds', 'Burger King', 'Wendys', 'Chipotle'] }
        before { allow(YAML).to receive(:load_file).with(described_class::RESTAURANT_DATA_PATH).and_return(restaurants) }

        it 'returns the array of contents' do
          expect(described_instance.restaurants).to contain_exactly(*restaurants)
        end
      end
    end

    context 'when the restaurant data file does not exist' do
      it 'returns an empty array' do
        expect(described_instance.restaurants).to eq([])
      end

      it 'creates a restaurant data file' do
        described_instance.restaurants

        expect(File.exist?(restaurant_data_path)).to eq(true)
      end
    end
  end

  describe '#sample' do
    let(:restaurants) { ['McDonalds', 'Burger King', 'Wendys', 'Chipotle'] }

    before { allow(YAML).to receive(:load_file).with(described_class::RESTAURANT_DATA_PATH).and_return(restaurants) }

    it 'returns a random restaurant' do
      expect(restaurants).to include(described_instance.sample)
    end
  end

  describe '#save' do
    it 'returns true' do
      expect(described_instance.save).to eq(true)
    end

    it 'saves restaurants to restaurant data file' do
      described_instance.restaurants = ['foobar']
      described_instance.save

      expect(YAML.load_file(restaurant_data_path)).to contain_exactly('foobar')
    end

    context 'when restaurants is not an Array' do
      before { described_instance.restaurants = 'foobar' }

      it 'returns false' do
        expect(described_instance.save).to eq(false)
      end

      it 'does not save restaurants to restaurant data file' do
        expect(YAML.load_file(restaurant_data_path)).to_not contain_exactly('foobar')
      end
    end

    context "when at least one restaurants' elements is not a String" do
      before { described_instance.restaurants = ['foobar', :raboof] }

      it 'returns false' do
        expect(described_instance.save).to eq(false)
      end

      it 'does not save restaurants to restaurant data file' do
        expect(YAML.load_file(restaurant_data_path)).to_not contain_exactly('foobar')
      end
    end
  end

  describe '#save!' do
    it 'returns true' do
      expect(described_instance.save!).to eq(true)
    end

    it 'saves restaurants to restaurant data file' do
      described_instance.restaurants = ['foobar']
      described_instance.save!

      expect(YAML.load_file(restaurant_data_path)).to contain_exactly('foobar')
    end

    context 'when restaurants is not an Array' do
      before { described_instance.restaurants = 'foobar' }

      it 'raises an error' do
        expect { described_instance.save! }.to raise_error(StarvingKuu::Error::Validation)
      end

      it 'does not save restaurants to restaurant data file' do
        expect(YAML.load_file(restaurant_data_path)).to_not contain_exactly('foobar')
      end
    end

    context "when at least one restaurants' elements is not a String" do
      before { described_instance.restaurants = ['foobar', :raboof] }

      it 'raises an error' do
        expect { described_instance.save! }.to raise_error(StarvingKuu::Error::Validation)
      end

      it 'does not save restaurants to restaurant data file' do
        expect(YAML.load_file(restaurant_data_path)).to_not contain_exactly('foobar')
      end
    end
  end
end
