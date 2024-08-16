# frozen_string_literal: true

begin
  require 'bundler'
rescue LoadError => e
  warn e.message
  warn "Run `gem install bundler` to install Bundler"
  exit(-1)
end

begin
  Bundler.setup(:development)
rescue Bundler::BundlerError => e
  warn e.message
  warn "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

require 'rubygems/tasks'
Gem::Tasks.new(sign: {checksum: true, pgp: true})

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

namespace :spec do
  RSpec::Core::RakeTask.new(:integration) do |t|
    t.rspec_opts = '--tag integration'
  end
end

task :test    => [:spec, 'spec:integration']
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
task :docs => :yard

require 'kramdown/man/task'
Kramdown::Man::Task.new

require 'command_kit/completion/task'
CommandKit::Completion::Task.new(
  class_file:  'ronin/payloads/cli',
  class_name:  'Ronin::Payloads::CLI',
  input_file:  'data/completions/ronin-payloads.yml',
  output_file: 'data/completions/ronin-payloads'
)

task :setup => %w[man command_kit:completion]
