# Curri App

## Getting Started
The development environment requires Ruby 2.0 and Postgresql. To get this setup please follow the instructions in the [Wiki](https://github.com/aomra015/curri/wiki). After that:

1. `$ git clone git@github.com:aomra015/curri.git`
2. `$ cd curri`
3. `$ bundle install`
4. `rake db:setup`

### Start development environment (at localhost:3000)
- `$ foreman start -f Procfile-dev`

### Run tests
- `$ rake test` to run Ruby tests.
- `$ guard` to run JavaScript tests. Note that you need to have phantomjs installed (`$ brew install phantomjs`).