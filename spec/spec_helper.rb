require 'rubygems'
require 'logger'

unless defined? Rubinius
  require 'simplecov'
  SimpleCov.start
end

begin
  require 'pry-byebug'
rescue LoadError
end

# Set up gems listed in the Gemfile.
begin
  ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', File.dirname(__FILE__))
  require 'bundler'
  Bundler.setup
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts 'Try running `bundle install`.'
  exit!
end

Bundler.require(:spec)

require 'setka-workflow'
require 'webmock/rspec'
require 'stringio'

Setka::Workflow.logger = Logger.new(StringIO.new)

RSpec.configure do |rspec|
  rspec.filter_run_excluding broken: true

  rspec.before :each do
    Setka::Workflow.reset!
  end

  rspec.around(:each, :silence_warnings) do |example|
    verbose = $VERBOSE
    $VERBOSE = nil
    example.run
    $VERBOSE = verbose
  end
end
