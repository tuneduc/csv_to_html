require 'thor'
require 'erb'
require 'csv'
require 'csv_to_html/row'

module CsvToHtml
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    desc 'build ERB_TEMPLATE CSV OUTPUT_PATH',
         'Build files from the ERB template and CSV file'
    def build(erb_path, csv_path, output_path)
      raise Thor::Error, 'ERB template file not found!' \
        unless File.exist? erb_path

      raise Thor::Error, 'CSV file not found!' unless File.exist? csv_path

      raise Thor::Error, 'Output path not a directory!' \
        unless Dir.exist? output_path

      erb = ERB.new File.read(erb_path)

      CSV.foreach(csv_path, headers: true).with_index(1) do |row, i|
        row_output = CsvToHtml::Row.new(row).render(erb)
        File.write "#{output_path}/#{i}.html", row_output
      end
    end
  end
end
