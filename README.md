# README

## What's this app?!
Rails Engine is an e-commerce application that tracks merchants, customer, items, and invoices. Information is stored in a database and accessed via internal api between Front-End and Back-End pieces of the application.

## Learning Goals
- Exposing an API
- Use serializers to format JSON responses
- Test API exposure
- Compose advanced ActiveRecord queries to analyze information stored in SQL databases

## Versions
- Ruby 2.5.3
- Rails 5.2.4.4

## Setup
1. Create a directory (e.g. rails_engine) as a parent directory
1. `cd` into that directory and run the following commands:

   ```
   git clone git@github.com:turingschool-examples/rails_driver.git
   ```
   - This will clone the [front end repo](https://github.com/turingschool-examples/rails_driver.git) of this project that contains a test suite  

   ```
   git clone git@github.com:jakeheft/rails_engine.git
   ```
   - This will clone the [back end repo](https://github.com/jakeheft/rails_engine) of this project  

   **_Both of these directories should live inside the parent directory you made_**
1. `cd` into rails_engine (child directory) and run `bundle install` and then ` rails g rspec:install`
1. From inside the rails_engine (child directory), run `rails db:{drop,create,migrate,seed}`. To get the spec harness to pass (see 'Running Tests' below), you will need to have the database properly seeded.

## Running Tests

To test the interconnectivity of this application with the Front-End application (rails_driver),  run `rails s` while inside this project's root directory (rails_engine child directory). Then in another terminal window, run `bundle exec rspec spec/features/harness_spec.rb` to run the tests.

The Back-End has also been fully tested with 100% test coverage in SimpleCov.

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* System dependencies

* Configuration

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
