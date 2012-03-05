spec = Gem::Specification.new do |s|
  s.name = 'anagram'
  s.version = '0.0.1'
  s.date = "2012-02-21"
  s.summary = "Makes anagrams of a word."
  s.description = <<-EOF
anagram is an executable that gives you the anagrams
of a given word
EOF
  s.authors = ["Casiano Rodriguez"]
  s.email = 'casiano.rodriguez.leon@gmail.com'
  s.files = Dir['**/**']
  s.homepage = 'http://rubygems.org/gems/anagram_casiano'
  s.platform = Gem::Platform::RUBY
  s.requirements << 'none'
  s.require_path = 'lib'
end