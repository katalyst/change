require "tmpdir"

desc "Setup the environment."
task :environment do
  ENV["PROJECT_ROOT"] = File.dirname(__FILE__)
  ENV["PATH"] = [
    File.join(ENV["PROJECT_ROOT"], "bin"),
    ENV["PATH"]
  ].join(":")
end

namespace :test do

  desc "Run the feature tests."
  task :features => :environment do

    Dir["test/features/*.rb"].each do |test|

      puts test

      Dir.mktmpdir do |dir|

        begin

          ENV["TEST_DIR"] = dir

          Dir.chdir(ENV["TEST_DIR"])

          require_relative test

          system("tput setaf 2")
          puts "PASS"
          system("tput sgr0")

        rescue Exception => error

          if Rake.application.options.trace == true
            raise error
          else
            system("tput setaf 1")
            puts "ERROR: #{error}"
            system("tput sgr0")
          end

        end

      end

    end

  end

end

task :default => "test:features"
