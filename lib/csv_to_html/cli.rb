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
      validate_input(erb_path, csv_path, output_path)

      erb = ERB.new File.read(erb_path)

      CSV.foreach(csv_path, headers: true).with_index(1) do |row, i|
        row_output = CsvToHtml::Row.new(row).render(erb)
        File.write "#{output_path}/#{i}.html", row_output
      end
    end

    private

    def validate_input(erb_path, csv_path, output_path)
      errors = {
        'ERB template not found' => !File.exist?(erb_path),
        'CSV file not found' => !File.exist?(csv_path),
        'Output directory not found' => !Dir.exist?(output_path)
      }

      return unless errors.values.any?

      raise Thor::Error, 'The following errors occured:\n' \
                         "#{errors.select { |_k, v| v }.keys.join('\n')}"
    end
  end
end
