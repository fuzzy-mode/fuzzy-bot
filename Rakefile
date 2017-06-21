require 'rubygems'

require 'dotenv'
Dotenv.load

require 'rspec/core'
require 'rspec/core/rake_task'

require 'standalone_migrations'
StandaloneMigrations::Tasks.load_tasks

task default: [:spec]
