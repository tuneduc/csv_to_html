require 'spec_helper'

RSpec.describe CsvToHtml::CLI do
  describe 'Command not found' do
    it 'exits with error' do
      expect(described_class.exit_on_failure?).to eq true
    end
  end
end
