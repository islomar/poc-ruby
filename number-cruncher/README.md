## Number cruncher

Example based on https://www.sitepoint.com/build-sinatra-api-using-tdd-heroku-continuous-integration-travis/

NB: the Travis and Heroku integrations don't work because the app is not at the root folder of the directory.

## How to run it
In order to run the web app: `bundle exec rackup`

In order to deploy to Heroku, from the repo root folder, run:
`git push heroku 'git subtree split --prefix number-cruncher branch':master --force`


## Heroku
* Heroku and Rack-based apps: https://devcenter.heroku.com/articles/rack
* https://brettdewoody.com/deploying-a-heroku-app-from-a-subdirectory/


## Travis
* Travis works by running a rake task, so you need to create a Rakefile.
* Add travis dependencies to Gemfile
* Run `travis init ruby --rvm 2.5.0`