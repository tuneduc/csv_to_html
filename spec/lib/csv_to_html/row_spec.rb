require 'spec_helper'
require 'csv'
require 'csv_to_html/row'

RSpec.describe CsvToHtml::Row do
  let!(:csv) { CSV.read 'spec/fixtures/people.csv', headers: true }
  let!(:csv_row) { csv[0] }

  subject { CsvToHtml::Row.new(csv_row) }

  describe '#initialize' do
    it 'creates methods from columns' do
      expect(subject.public_methods).to include :id
      expect(subject.public_methods).to include :name

      expect(subject.id).to eq csv_row['id']
      expect(subject.name).to eq csv_row['name']
    end
  end

  describe '#render' do
    let!(:html) { 'The id is <%= id %> and the name is <%= name %>' }
    let!(:template) { ERB.new(html) }
    let!(:output) do
      "The id is #{csv_row['id']} and the name is #{csv_row['name']}"
    end

    it 'renders ERB with row binding' do
      expect(subject.render(template)).to eq output
    end
  end
end
