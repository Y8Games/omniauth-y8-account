# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-y8_account/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['François Turbelin', 'Tomas Brazys']
  gem.email         = ['francois.t@webgroup-limited.com', 'tomas.b@webgroup-limited.com']
  gem.description   = %q{Official OmniAuth strategy for Y8 Account.}
  gem.summary       = %q{Official OmniAuth strategy for Y8 Account.}
  gem.homepage      = 'https://github.com/Y8Games/omniauth-y8_account'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'omniauth-y8_account'
  gem.require_paths = ['lib']
  gem.version       = OmniAuth::Y8Account::VERSION

  gem.add_dependency 'omniauth', '~> 2.1'
  gem.add_dependency 'omniauth-oauth2', '~> 1.8'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
end
