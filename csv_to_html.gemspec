lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csv_to_html/version'

Gem::Specification.new do |spec|
  spec.name          = 'csv_to_html'
  spec.version       = CsvToHtml::VERSION
  spec.authors       = ['Rafael Meneses']
  spec.email         = ['rafael.meneses@tuneduc.com.br']

  spec.summary       = ''
  spec.description   = 'Generate HTML from an erb template and a csv'
  spec.homepage      = 'http://www.github.com/tuneduc/csv_to_html'

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.executables   = ['csv_to_html']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'fakefs', '~> 1.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.8'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.80'
  spec.add_development_dependency 'simplecov', '~> 0.18'

  spec.add_dependency 'thor', '~> 1.0'
end
