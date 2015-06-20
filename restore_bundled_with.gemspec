# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'restore_bundled_with/version'

Gem::Specification.new do |spec|
  spec.name          = 'restore_bundled_with'
  spec.version       = RestoreBundledWith::VERSION
  spec.authors       = ['sanemat']
  spec.email         = ['o.gata.ken@gmail.com']

  spec.summary       = 'Restore BUNDLED WITH section on Gemfile.lock'
  spec.description   = 'Restore BUNDLED WITH section on Gemfile.lock'
  spec.homepage      = 'https://github.com/packsaddle/ruby-restore_bundled_with'
  spec.license       = 'MIT'

  spec.files         = \
    `git ls-files -z`
      .split("\x0")
      .reject { |f| f.match(%r{^(test|spec|features)/}) }
      .reject do |f|
      [
        '.travis.yml',
        'circle.yml',
        '.tachikoma.yml',
        'package.json'
      ].include?(f)
    end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor', '>= 0'
  spec.add_runtime_dependency 'git', '>= 0'

  spec.add_development_dependency 'bundler', '>= 0'
  spec.add_development_dependency 'rake', '>= 0'
  spec.add_development_dependency 'test-unit', '>= 0'
  spec.add_development_dependency 'test-unit-rr', '>= 0'
end
