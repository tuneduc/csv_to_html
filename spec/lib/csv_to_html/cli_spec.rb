require 'spec_helper'

RSpec.describe CsvToHtml::CLI do
  describe 'Command not found' do
    it 'exits with error' do
      expect(described_class.exit_on_failure?).to eq true
    end
  end

  describe '#build' do
    context 'Inexistent files' do
      let!(:erb_path) { 'spec/fixtures/person.html.erb' }
      let!(:csv_path) { 'spec/fixtures/people.csv' }
      let!(:wrong_erb_path) { 'spec/this/is/not/a/file' }
      let!(:wrong_csv_path) { 'spec/this/is/not/a/file' }
      let!(:wrong_output_path) { 'spec/this/is/not/a/dir' }

      it 'raises error for wrong erb path' do
        expect do
          subject.build(wrong_erb_path, wrong_csv_path, wrong_output_path)
        end.to raise_error Thor::Error, 'ERB template file not found!'
      end

      it 'raises error for wrong csv path' do
        expect do
          subject.build(erb_path, wrong_csv_path, wrong_output_path)
        end.to raise_error Thor::Error, 'CSV file not found!'
      end

      it 'raises error for wrong csv path' do
        expect { subject.build(erb_path, csv_path, wrong_output_path) }.to \
          raise_error Thor::Error, 'Output path not a directory!'
      end
    end
  end
end
