# Curri App

## Getting Started
The development environment requires Ruby 2.0 and Postgresql. To get this setup please follow the instructions in the [Wiki](https://github.com/aomra015/curry/wiki). After that:

1. `$ git clone git@github.com:aomra015/curry.git`
2. `$ cd curry`
3. `$ bundle install`
4. `rake db:setup`

### Start development environment (at localhost:3000)
- `$ foreman start -f Procfile-dev`

### Run tests
- `$ rake test`