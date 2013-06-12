# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-idnet/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Vlad Shvedov", "Hery Ramihajamalala"]
  gem.email         = ["vshvedov@heliostech.hk", "hery@heliostech.fr"]
  gem.description   = %q{Official OmniAuth strategy for IdNet.}
  gem.summary       = %q{Official OmniAuth strategy for IdNet.}
  gem.homepage      = "https://github.com/idnet/omniauth-idnet"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-idnet"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Idnet::VERSION

  gem.add_dependency 'omniauth', '~> 1.1'
  gem.add_dependency 'omniauth-oauth2', '~> 1.1'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
