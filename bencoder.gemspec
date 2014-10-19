Gem::Specification.new do |s|
  s.name        = 'bencoder'
  s.version     = '0.1.0'
  s.summary     = 'Bittorrent encoding'
  s.description = 'Minimalistic BEncoding gem'
  s.authors     = ['Kasper Holbek Jensen']
  s.email       = 'kholbekj@gmail.com'
  s.files       =  Dir['Rakefile', '{lib,test}/**/*', 'README*']
  s.homepage    = 'https://github.com/kholbekj/bencoder'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 1.9.3'
  s.add_development_dependency 'minitest', '~> 5.4', '>= 5.4.0'
  s.add_development_dependency 'coveralls', '~> 0.7.0', '>= 0.7.0'
end 
