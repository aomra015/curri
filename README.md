# Curri App

## Getting Started
The development environment requires Ruby 2.0 and Postgresql. To get this setup please follow the instructions in the [Wiki](https://github.com/aomra015/curri/wiki). After that:

1. `$ git clone git@github.com:aomra015/curri.git`
2. `$ cd curri`
3. `$ bundle install`
4. `rake db:setup`

### Start development environment (at localhost:3000)
- `$ foreman start`

### Run tests
- `$ rake minitest` to run all Ruby tests.
- `$ rake minitest:<type>` to run just tests of that type. Use `:models`, `:controllers`, `:helpers`, `:services`, `:features` etc.
- `$ rake teaspoon` to run JavaScript tests.

Note that you need to have phantomjs installed (`$ brew install phantomjs`) to run the JavaScript tests.