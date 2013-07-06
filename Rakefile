require "tmpdir"

namespace :test do

  desc "Run the functional tests."
  task :functional do

    system("alias change='bin/change'")

    Dir["test/functional/*.rb"].each do |test|

      puts test

      Dir.mktmpdir do |dir|

        begin

          Dir.chdir(dir)

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

task :default => "test:functional"
