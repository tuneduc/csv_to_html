require 'spec_helper'
require 'csv'
require 'csv_to_html/row'

RSpec.describe CsvToHtml::Row do
  describe '#initialize' do
    let!(:csv) { CSV.read 'spec/fixtures/people.csv', headers: true }
    let!(:csv_row) { csv[0] }

    subject { CsvToHtml::Row.new(csv_row) }

    it 'creates methods from columns' do
      expect(subject.public_methods).to include :id
      expect(subject.public_methods).to include :name

      expect(subject.id).to eq csv_row['id']
      expect(subject.name).to eq csv_row['name']
    end
  end
end
