module CsvToHtml
  class Row
    def initialize(csv_row)
      csv_row.headers.each do |column|
        self.class.send :define_method, column.to_sym do
          csv_row[column]
        end
      end
    end
  end
end
