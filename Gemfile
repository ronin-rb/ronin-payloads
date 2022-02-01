source 'https://rubygems.org'

RONIN_URI = 'https://github.com/ronin-rb'

gemspec

gem 'jruby-openssl',	'~> 0.7', platforms: :jruby

# gem 'fake_io', '~> 0.1', github: 'postmodern/fake_io.rb',
#                          branch: 'main'

# Ronin dependencies
gem 'ronin-post_ex',  '~> 0.1', git: "#{RONIN_URI}/ronin-post_ex.git",
                                branch: 'main'

gem 'ronin-core',     '~> 0.1', git: "#{RONIN_URI}/ronin-core.git",
                                branch: 'main'

gem 'ronin-repos',    '~> 0.1', git: "#{RONIN_URI}/ronin-repos.git",
                                branch: 'main'

group :development do
  gem 'rake'
  gem 'rubygems-tasks', '~> 0.2'

  gem 'rspec',          '~> 3.0'
  gem 'simplecov',      '~> 0.20'

  gem 'kramdown',      '~> 2.0'
  gem 'kramdown-man',  '~> 0.1'

  gem 'redcarpet',       platform: :mri
  gem 'yard',           '~> 0.9'
  gem 'yard-spellcheck', require: false

  gem 'dead_end', require: false
end
