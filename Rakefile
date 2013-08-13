#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

RSpec::Core::RakeTask.new(:nested_spec) do |t|
  t.rspec_opts = "--format nested"
end
task :nested => :nested_spec
