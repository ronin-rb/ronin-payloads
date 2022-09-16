source 'https://rubygems.org'

gemspec

gem 'jruby-openssl',	'~> 0.7', platforms: :jruby

# gem 'fake_io', '~> 0.1', github: 'postmodern/fake_io.rb',
#                          branch: 'main'

gem 'command_kit', '~> 0.4', github: 'postmodern/command_kit.rb',
                             branch: '0.4.0'

# Ronin dependencies
gem 'ronin-support',  '~> 1.0', github: "ronin-rb/ronin-support",
                                branch: '1.0.0'

gem 'ronin-code-asm', '~> 1.0', github: "ronin-rb/ronin-code-asm",
                                branch: '1.0.0'

gem 'ronin-post_ex',  '~> 0.1', github: "ronin-rb/ronin-post_ex",
                                branch: 'main'

gem 'ronin-core',     '~> 0.1', github: "ronin-rb/ronin-core",
                                branch: 'main'

gem 'ronin-repos',    '~> 0.1', github: "ronin-rb/ronin-repos",
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
