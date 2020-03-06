require 'spec_helper'

RSpec.describe CsvToHtml::CLI do
  describe 'Command not found' do
    it 'exits with error' do
      expect(described_class.exit_on_failure?).to eq true
    end
  end

  describe '#build' do
    let!(:fixtures_path) { File.expand_path '../../fixtures', __dir__ }
    let!(:erb_path) { File.join(fixtures_path, 'person.html.erb') }
    let!(:csv_path) { File.join(fixtures_path, 'people.csv') }

    context 'Inexistent files' do
      let!(:wrong_erb_path) { 'spec/this/is/not/a/file' }
      let!(:wrong_csv_path) { 'spec/this/is/not/a/file' }
      let!(:wrong_output_path) { 'spec/this/is/not/a/dir' }
      let!(:error_prefix) { 'The following errors occured:\n' }
      let!(:erb_error) { 'ERB template not found' }
      let!(:csv_error) { 'CSV file not found' }
      let!(:output_error) { 'Output directory not found' }

      it 'raises error for three wrong arguments' do
        expect do
          subject.build(wrong_erb_path, wrong_csv_path, wrong_output_path)
        end.to raise_error Thor::Error, "#{error_prefix}#{erb_error}\\n" \
                                        "#{csv_error}\\n#{output_error}"
      end

      it 'raises error for two wrong arguments' do
        expect do
          subject.build(erb_path, wrong_csv_path, wrong_output_path)
        end.to raise_error Thor::Error, "#{error_prefix}#{csv_error}\\n" \
                                        "#{output_error}"
      end

      it 'raises error for one wrong argument' do
        expect { subject.build(erb_path, csv_path, wrong_output_path) }.to \
          raise_error Thor::Error, "#{error_prefix}#{output_error}"
      end
    end

    context 'Existent files' do
      include FakeFS::SpecHelpers

      let!(:output_path) { File.join('/', 'home', 'output') }
      let(:file_list) { Dir.glob File.join(output_path, '*') }

      before do
        FakeFS::FileSystem.clone fixtures_path
        FileUtils.mkdir_p output_path
      end

      context 'Default delimiter' do
        before do
          subject.invoke(:build, [erb_path, csv_path, output_path])
        end

        it 'creates files in desired path' do
          expect(file_list.size).to eq 3
          expect(file_list).to include File.join(output_path, '1.html')
          expect(file_list).to include File.join(output_path, '2.html')
          expect(file_list).to include File.join(output_path, '3.html')
        end

        it 'generates correct output' do
          file_list.each do |output|
            expect(File.read(output)).to eq \
              File.read File.join(fixtures_path, 'output',
                                  File.basename(output))
          end
        end
      end

      context 'Different delimiter' do
        let!(:csv) { "id;name\n1;Paul" }

        before do
          File.write csv_path, csv

          subject.invoke(:build, [erb_path, csv_path, output_path],
                         delimiter: ';')
        end

        it 'reads the csv with specified delimiter' do
          expect(file_list.size).to eq 1
          expect(File.read(File.join(output_path, '1.html'))).to eq \
            File.read(File.join(fixtures_path, 'output', '1.html'))
        end
      end

      context 'Filename column' do
        before do
          subject.invoke(:build, [erb_path, csv_path, output_path],
                         'filename-col': 'name')
        end

        it 'uses filename_col as filename' do
          expect(file_list.size).to eq 3
          expect(file_list).to include File.join(output_path, 'Paul.html')
          expect(file_list).to include File.join(output_path, 'John.html')
          expect(file_list).to include File.join(output_path, 'Anne.html')
        end
      end
    end
  end
end
