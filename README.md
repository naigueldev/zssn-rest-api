# ZSSN (Zombie Survival Social Network) - REST API

## Install

Before the installation, make sure to have the Ruby 2.3.1 installed.
After that, for the application install, download it and run the following commands:

```
gem install bundle
bundle install
rails db:create
rails db:migrate
```

Then, run `rails s`, and it will be available at http://localhost:3000

-------------------------------------------------------------------------

## API Documentation

### POST /survivors


### GET /survivor/:id


### PUT /survivor/:id


### POST /survivor/:id/report_infection

### POST /trade


### GET /reports/infected
Percentage of infected survivors.


### GET /reports/non-infected
Percentage of non-infected survivors.

### GET /reports/inventories
Average amount of each kind of resource by survivor.

### GET /reports/points
Points lost because of infected survivor.


## Testing with RSpec

To execute the tests just run the tests with RSpec.

Execute all tests

~~~ sh
$ bundle exec rspec
~~~
