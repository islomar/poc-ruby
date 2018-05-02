# poc-ruby
Time to play a little bit with Ruby and its ecosystem :-)

## General information
* https://www.ruby-lang.org/en/
* Better install Ruby with rbenv
    * https://cbednarski.com/articles/installing-ruby/
* POODR:
    * https://github.com/skmetz/poodr
    * https://github.com/islomar/my-readings/blob/master/practical-object-oriented-design-in-ruby.md
    * Factory (Wrapper) a a module.
    * include <Module> for sharing role behavior
* Last Ruby release (15.04.2018): 2.5.1
* The reference or original implementation of the Ruby programming language is called Matz's Ruby Interpreter, or **MRI** for short.
* **gemspec**: http://guides.rubygems.org/specification-reference/
* **RVM**: Ruby Version Manager
* **rbenv**
    * https://github.com/rbenv/rbenv
    * https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-16-04
    * rbenv is concerned solely with switching Ruby versions.
    * Use rbenv to pick a Ruby version for your application and guarantee that your development environment matches production.
* IRB: Interactive Ruby Shell
* VS Code: installed Ruby extension
* Docker: https://hub.docker.com/_/ruby/
    * Run IRB: `docker run -ti ruby:2.5 irb`
* **bundler**
    * http://bundler.io/
    * Gem manager
    * Looks like pip in Python
    * Installation: `gem install bundler`
    * Specify your dependencies in a Gemfile in your project's root:
    * Run `bundle install --binstubs`
    * `git add Gemfile Gemfile.lock`
    * If necessary, you can specify that a gem is located at a particular git repository using the :git parameter.
    * Located at `~/.bundle`
* **Rake** = Ruby make
    * (https://github.com/ruby/rake)
    * It runs the Rakefile (~ Makefile)


## Ruby language
* it uses snake case for methods and attributes, like Python
* `nil` is an object
* methods: def-end
* every object has an id (att `object_id`) and a String representation (`to_s`)
* every object has a different id (small integers have fixed ids, which is numberx2 + 1)
* Array vs Range classes
* `shift` retrieve and remove the first item of a list
* parentheses are not needed for calling a method without parameters
* Optional parameters: `def hi(name = "World")`
* Insert a variable in a string with # `puts "Hello #{name.capitalize}!"`
* Instance variables with @, e.g. `@name`. They are private.
* For defining public instance variables: `attr_accessor :name`
* Instantiate a class: `Greeter.new("Pat")`
* Safe-navigation operator: `provider&.password`
* `config.ru`
    * rackup file, in order to simplify running the Sinatra app (or any Rack app)
    * https://learn.co/lessons/config-ru-tutorial
    * TBD
* Ruby modules have two roles:
    1. Grouping similar methods together under a familiar name
    2. TBD


## Tutorials
* http://rubykoans.com/
    * Install `observr` (`watch` failed https://github.com/mynyml/watchr/issues/58) and run `observr ./koans.watchr`
* Ruby in 20 minutes: https://www.ruby-lang.org/en/documentation/quickstart/ (DONE, example MegaGreeter.rb)
* Sinatra
    * http://sinatrarb.com/intro.html
        * Sinatra tests can be written using any Rack-based testing library or framework. Rack::Test is recommended.
    * Hello world: https://coderwall.com/p/3k1hsw/hello-world-with-sinatra (DONE)
    * TDD and Sinatra: https://rubyplus.com/articles/1881-Sinatra-Beyond-Basics-TDD-using-Sinatra (DONE)
        * http://www.virtuouscode.com/2014/07/08/zero-to-smoke-test-with-sinatra/
    * TDD + Sinatra + Travis + Heroku: https://www.sitepoint.com/build-sinatra-api-using-tdd-heroku-continuous-integration-travis/ (DONE)
    * https://www.sitepoint.com/build-a-sinatra-mvc-framework/

## Testing
* RSpec
    * http://rspec.info/
    * Testing Ruby with RSpec:
        * https://codecast.qualified.io/interaction/58373a35258123054227a7b1 (DONE)
    * Set up the project for running RSpec: `rspec --init`
    * `bin/rspec --init`: create `.rspec` and `spec/spec_helper.rb`
    * Run the tests under folder "spec": `bin/rspec format doc`
    * Add `:focus` for focusing on a test:    `it "does another thing", :focus => true do`
    * Assert exceptions:
        ```
        exception = assert_raise(___) do
            my_global_method(1,2,3)
        end
        assert_match(/__/, exception.message)
        ```
    * TBD
* Hexagonal TDD with Ruby and RSpec: https://moonmaster9000.github.io/hexagonal_tdd_in_ruby/ (DONE)
* Dani Latorre => Testing en Invoice_Me. Cucumber, RSpec, Capybara, Selenium: (DONE)
    * https://www.youtube.com/watch?v=iEmBIj95jdI
    * https://www.youtube.com/watch?v=8ok8q8duvYc
    * https://github.com/codingstones/invoice_me
    * Sinatra, RSpec, Cucumber
    * `gem install bundler` before running `bundle install`
    * It uses the gem `dry-validation` for validating data coming from the outside.
    * gema `vcr` for recording the answer from external services. It uses `webmock`.
    * `rack-test` for Sinatra testing.
    * `capybara/cucumber` for end-to-end tests
    * `config.ru` looks like the entry point for Sinatra
    * `app.rb`: initializations, controllers.
    * Use of `require_relative`
    * They don't use `return`
    * Coverage: SimpleCov, it starts it at spec_helper.rb
    * Testing
        * `rspec spec/invoice_me --format documentation`
        * `AUTH_TOKEN=xxx ORIGIN_ACCOUNT=xxx rake features:e2e`  >> it runs with a headless Chrome
        * All the tests under `spec` use a fake Cuentica server (VCR cassettes)
        * The tests under `features` run against the real Cuentica server
* Cucumber:
    * Sinatra examples: https://github.com/cucumber/cucumber-ruby/blob/master/examples/sinatra/features/add.feature
    * Ruby examples: https://github.com/bmabey/cucumber/tree/master/features
* Capybara
    * Acceptance test framework for web applications http://teamcapybara.github.io/capybara/
    * It gives me all the functionality for the page objects, like @context.fill_in, etc.
* RackTest:
    * Capybara default driver: https://github.com/teamcapybara/capybara#racktest


## Topics to take a look
* Rack:
    * Rack provides a minimal, modular, and adaptable interface for developing web applications in Ruby.
    * E.g. Sinatra or Rails are Rack web frameworks.
* Sinatra


## How to create a project
* Create Gemfile
* `rspec --init`
* `bundle`
* Edit .rspec to include color and format documentation
* In spec_helper.rb (invoice_me example):
```
module SinatraMixin
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end
```
* TBD