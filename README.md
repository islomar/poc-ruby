# poc-ruby
Time to play a little bit with Ruby and its ecosystem :-)

## General information
* https://www.ruby-lang.org/en/
* Last Ruby release (15.04.2018): 2.5.1
* RVM: Ruby Version Manager
* IRB: Interactive Ruby Shell
* Docker: https://hub.docker.com/_/ruby/
    * Run IRB: `docker run -ti ruby:2.5 irb`
* Rake = Ruby make
    * (https://github.com/ruby/rake)
    * It runs the Rakefile (~ Makefile)
* TBD


## Tutorials
* http://rubykoans.com/
    * Install `observr` (`watch` failed https://github.com/mynyml/watchr/issues/58) and run `observr ./koans.watchr`
* https://www.ruby-lang.org/en/documentation/quickstart/


## Testing
* RSpec
    * Testing Ruby with RSpec:
        * https://codecast.qualified.io/interaction/58373a35258123054227a7b1
* Capybara
    * Acceptance test framework for web applications http://teamcapybara.github.io/capybara/
* RackTest:
    * Capybara default driver: https://github.com/teamcapybara/capybara#racktest


## Topics to take a look
* Rack:
    * Rack provides a minimal, modular, and adaptable interface for developing web applications in Ruby.
    * E.g. Sinatra or Rails are Rack web frameworks.
* Sinatra
