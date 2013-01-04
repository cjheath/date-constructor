require 'rubygems'
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "date-constructor"
  gem.homepage = "http://github.com/cjheath/date-constructor"
  gem.license = "MIT"
  gem.summary = "Add flexible constructors to Ruby's Date and DateTime"
  gem.description = %q{
Date and DateTime don't have sensible constructors. You can't construct
one using an existing Date/Time, nor by passing a string to be parsed.
Instead you have to call special-purpose routines. This gem adds some
sensible options to the existing modes of the constructors
}
  gem.email = "clifford.heath@gmail.com"
  gem.authors = ["Clifford Heath"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  gem.add_development_dependency "bundler", "~> 1.0.0"
  gem.add_development_dependency "rdoc", ">= 2.4.2"
  gem.files = [
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "date-constructor.gemspec",
    "lib/date/constructor.rb",
    "test/test_date.rb",
    "test/test_date_arith.rb",
    "test/test_date_attr.rb",
    "test/test_date_base.rb",
    "test/test_date_compat.rb",
    "test/test_date_conv.rb",
    "test/test_date_marshal.rb",
    "test/test_date_new.rb",
    "test/test_date_parse.rb",
    "test/test_date_strftime.rb",
    "test/test_date_strptime.rb",
    "test/test_switch_hitter.rb"
  ]
end
Jeweler::RubygemsDotOrgTasks.new

task :default => :test

require 'rake/testtask'
Rake::TestTask.new do |t|
  here = "#{File.dirname(__FILE__)}"
  t.libs << "test"
  t.test_files = FileList['test/test_*.rb']
  t.options = "-q"
  load "#{here}/lib/date/constructor.rb"
end

namespace :test do
  namespace :rubies do
    SUPPORTED_RUBIES = %w{ 1.8.7 1.9.2 1.9.3 jruby-1.7.0 rbx }

    desc "Run tests on all supported rubies"
    task :all_tasks => [:install_gems, :exec]

    desc "Run `bundle install` on all rubies"
    task :install_gems do
      sh %{ rvm #{SUPPORTED_RUBIES.join(',')} exec bundle install }
    end

    desc "Run `bundle exec rake` on all rubies"
    task :exec do
      sh %{ rvm #{SUPPORTED_RUBIES.join(',')} exec bundle exec rake test }
    end
  end
end

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "date-constructor #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
