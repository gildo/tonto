Gem::Specification.new do |s|
  
  s.name              = 'tonto'
  s.version           = '0.0.0'
  s.date              = '2011-01-13'

  s.summary     = "stupid key-value document store ( that uses git as DB )."
  s.description = "**tonto** ( which can be translated from Italian to *git* ) is a _simple_, _high-level_ and a bit _stupid_ document-oriented store that allows you to use git repos as schema-less NoSQL databases."

  s.authors  = ["Ermenegildo Fiorito"]
  s.email    = 'fiorito.g@gmail.com'
  s.homepage = 'http://github.com/fyskij/tonto#readme'

  s.require_paths = %w[lib]
  s.files = %w( README.md )
  s.files += Dir.glob("lib/**/*")
  s.files += Dir.glob("test/*")
  
  s.add_dependency('grit')
  s.add_dependency('json')


  #s.add_development_dependency('DEVDEPNAME', [">= 1.1.0", "< 2.0.0"])


  s.test_files = s.files.select { |path| path =~ /^test\/test_.*\.rb/ }
end
