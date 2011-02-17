require File.expand_path("../lib/tonto", __FILE__)

Gem::Specification.new do |s|
  
  s.name              = 'tonto'
  s.version           = Tonto::VERSION
  
  s.summary = "stupid key-value document store ( that uses git as DB )."
  s.description = "tonto is a simple, high-level and a bit _stupid_ document-oriented store that allows you to use git repos as schema-less NoSQL databases."

  s.authors  = ["Gildo Fiorito"]
  s.homepage = 'http://github.com/fyskij/tonto#readme'

  s.require_paths = %w[lib]

  s.files = %w( README.md )
  s.files += Dir.glob("lib/**/*")
  s.files += Dir.glob("test/*")

  s.add_dependency('grit', "~> 2.4.1")
  
  s.add_development_dependency('turn')

  s.test_files = s.files.select { |path| path =~ /^test\/test_.*\.rb/ }

end
