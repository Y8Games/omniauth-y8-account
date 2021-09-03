# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-y8_account/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Vlad Shvedov", "Hery Ramihajamalala"]
  gem.email         = ["vshvedov@heliostech.hk", "hery@heliostech.fr"]
  gem.description   = %q{Official OmniAuth strategy for Y8 Account.}
  gem.summary       = %q{Official OmniAuth strategy for Y8 Account.}
  gem.homepage      = 'https://github.com/Y8Games/omniauth-y8_account'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'omniauth-y8_account'
  gem.require_paths = ['lib']
  gem.version       = OmniAuth::Y8Account::VERSION

  gem.add_dependency 'omniauth', '~> 1.9'
  gem.add_dependency 'omniauth-oauth2', '~> 1.7'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
