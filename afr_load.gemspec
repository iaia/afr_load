# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'afr_load/version'

Gem::Specification.new do |spec|
  spec.name          = "afr_load"
  spec.version       = AfrLoad::VERSION
  spec.authors       = ["iaia"]
  spec.email         = ["iaia72160@gmail.com"]

  spec.summary       = %q{Web Scraping for 午後のロードショー}
  spec.description   = %q{午後ローのウェブスクレイピング。放送日、タイトル、映画に関する情報を取得します。}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_dependency "oga"
  spec.add_dependency "httpclient"
end
