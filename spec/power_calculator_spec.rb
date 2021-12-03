require 'rspec'
require_relative '../solutions/d3'

RSpec.describe PowerCalculator do
  subject { described_class.new(test_data) }
  let(:test_data) { nil }

  describe 'initialize' do
    context 'when no test data is provided' do

      it 'reads the input file, when no test data is attached' do
        expect(subject.clean.count).to be > 100
      end
    end

    context 'when test data is provided' do
      let(:test_data) { "110000000001\n010011111011" }

      it 'reads the test data' do
        expect(subject.clean.count).to be 2
        expect(subject.clean).to eq ['110000000001', '010011111011']
      end
    end

    it 'has a rate_collection measurement' do
      expect(subject.rate_collection).to eq({ '0': [], "1": [], "2": [], '3': [], '4': [], '5': [], '6': [], '7': [], '8': [], '9': [], '10': [], '11': [] })
    end

    it 'has a placeholder gamma rate' do
      expect(subject.gamma).to eq ""
    end

    it 'has a placeholder epsilon rate' do
      expect(subject.epsilon).to eq ""
    end
  end

  describe ".input_into_rate_collection" do
    let(:power_calculator) { described_class.new(test_data) }
    let(:test_data) { "110000000001\n010011111011" }

    subject { power_calculator.input_into_rate_collection }

    it 'splits the input into the indexed rate_collection' do
      subject
      expect(power_calculator.rate_collection).to eq({ '0': [1, 0], "1": [1, 1], "2": [0, 0], '3': [0, 0], '4': [0, 1], '5': [0, 1], '6': [0, 1], '7': [0, 1], '8': [0, 1], '9': [0, 0], '10': [0, 1], '11': [1, 1] })

    end
  end

  describe 'most_common_bit' do
    subject { described_class.new.most_common_bit(rate_count) }

    context 'with majority 0 bits' do
      let(:rate_count) { [1, 0, 0] }

      it { is_expected.to eq 0 }
    end

    context 'with majority 1 bits' do
      let(:rate_count) { [1, 1, 0] }

      it { is_expected.to eq 1 }
    end

  end

  describe 'reduce_rate_collection' do
    let(:power_calculator) { described_class.new("placeholder") }

    subject { power_calculator.reduce_rate_collection }

    before do
      power_calculator.rate_collection = { '0': [1, 0, 0], "1": [1, 1, 1], "2": [0, 0, 1], '3': [0, 0, 0], '4': [0, 1, 1], '5': [0, 1, 0], '6': [0, 1, 1], '7': [0, 1, 0], '8': [0, 1, 1], '9': [0, 0, 0], '10': [0, 1, 1], '11': [1, 1, 1] }
    end

    it 'sets the gamma rate' do
      subject
      expect(power_calculator.gamma).to eq("010010101011")
    end
    it 'sets the epsilon rate' do
      subject
      expect(power_calculator.epsilon).to eq("101101010100")
    end
  end

  describe 'calculate' do
    let(:power_calculator) { described_class.new(test_data) }
    let(:test_data) { "110000000001\n010011111011\n111000011110" }

    # expected gamma from test input = 110000011011
    # expected epsilon from test input = 001111100100

    subject { power_calculator.calculate }

    it 'processes input data, and returns the product of the gamma and epsilon measurements' do
      expect(subject).to eq 3086604
      #gamma to decimal value = 3099
      # epsilon to decimal value = 996
      # 3099 * 996 = 3086604
    end


  end
end