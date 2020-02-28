require 'spec_helper'

RSpec.describe CsvToHtml::CLI do
  describe 'Command not found' do
    it 'exits with error' do
      expect(described_class.exit_on_failure?).to eq true
    end
  end

  describe '#build' do
    let!(:fixtures_path) { File.expand_path '../../fixtures', __dir__ }
    let!(:erb_path) { "#{fixtures_path}/person.html.erb" }
    let!(:csv_path) { "#{fixtures_path}/people.csv" }

    context 'Inexistent files' do
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

    context 'Existent files' do
      include FakeFS::SpecHelpers

      let!(:output_path) { '/home/output' }
      let(:file_list) { Dir.glob "#{output_path}/*" }

      before do
        FakeFS::FileSystem.clone fixtures_path
        FileUtils.mkdir_p output_path

        subject.build(erb_path, csv_path, output_path)
      end

      it 'creates files in desired path' do
        expect(file_list.size).to eq 3
        expect(file_list).to include "#{output_path}/1.html"
        expect(file_list).to include "#{output_path}/2.html"
        expect(file_list).to include "#{output_path}/3.html"
      end

      it 'generates correct output' do
        file_list.each do |output|
          expect(File.read(output)).to eq \
            File.read("#{fixtures_path}/output/#{File.basename(output)}")
        end
      end
    end
  end
end
