## Number cruncher

Example based on https://www.sitepoint.com/build-sinatra-api-using-tdd-heroku-continuous-integration-travis/


In order to run the web app: `bundle exec rackup`

In order to deploy to Heroku, from the repo root folder, run:
`git push heroku 'git subtree split --prefix number-cruncher branch':master --force`


## Heroku
* Heroku and Rack-based apps: https://devcenter.heroku.com/articles/rack
* https://brettdewoody.com/deploying-a-heroku-app-from-a-subdirectory/