require 'thor'

module CsvToHtml
  class CLI < Thor
    def self.exit_on_failure?
      true
    end
  end
end
