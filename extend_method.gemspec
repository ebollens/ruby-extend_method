Gem::Specification.new do |s|

  s.name        = 'extend_method'
  s.version     = '1.0.0'
  s.summary     = 'Simple mechanism for extending an existing method'
  s.authors     = ['Eric Bollens']
  s.email       = ['ebollens@ucla.edu']
  s.homepage    = 'https://github.com/ebollens/ruby-extend_method'
  s.license     = 'BSD'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency 'rake'
  s.add_development_dependency 'coveralls'

end