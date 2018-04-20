# Sinatra skeleton

The goal of this folder is to serve as template for a brand new Sinatra project, being ready for an Outside-In TDD approach, following an Interaction-Driven Design perspective.

* When the app grows, it will be better to create domain-focus folders for actions, model, etc.
* Mimic the business folders structure into the test folders structure (i.e. actions, model, etc).

## Testing
There is a skeleton with:
* RSpec
* Cucumber and Capybara for e2e tests

## Prerequisites
* For the e2e tests, you need the chromedriver installed: http://chromedriver.storage.googleapis.com/index.html

## How to run the tests
* Isolated tests: run `rake`
* End to end feature tests (Cucumber): ``

## How to run the Sinatra app
Run `bundle exec rackup` or `bundle exec rackup -p <port_number>`


## e2e testing (Cucumber)
* If you want to see why an e2e test is failing, add the step "Then show me the page" in order to save the HTML