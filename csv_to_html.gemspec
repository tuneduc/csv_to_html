lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "csv_to_html/version"

Gem::Specification.new do |spec|
  spec.name          = "csv_to_html"
  spec.version       = CsvToHtml::VERSION
  spec.authors       = ["Rafael Meneses"]
  spec.email         = ["rafael.meneses@tuneduc.com.br"]

  spec.summary       = ""
  spec.description   = "Generate HTML from an erb template and a csv"
  spec.homepage      = "http://www.github.com/tuneduc/csv_to_html"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
