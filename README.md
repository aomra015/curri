# Curri App

We saw too many frustrated teachers who wanted to know what their students were struggling with. We saw too many students who felt completely lost and didn't know what questions to ask. Curri was built to address this problem by improving student-teacher communication.

The app was built by Ahmed Omran, Paula Franzini, Nachiket Kumar, and Alexander Miloff. We talked to a lot of teachers and tested the app with HackerYou's first front-end bootcamp course. There was very little interest from teachers because it "sounds like a lot of work".

There is no intention right now of maintaining this project. We're open sourcing the code and putting an MIT license with the hope that someone might find it (or a component) useful.

## Getting Started

The development environment requires Ruby 2.1.1 and Postgresql. To get this setup please follow the instructions in the [Wiki](https://github.com/aomra015/curri/wiki). After that:

1. `$ git clone git@github.com:aomra015/curri.git`
2. `$ cd curri`
3. `$ bundle install`
4. `rake db:setup`

### Realtime

The realtime capabilities of Curri will only work if you have [Pusher](http://pusher.com/). Create a free account and put your credentials in `config/initializers/pusher.rb`.

### Start development environment (at localhost:3000)
- `$ foreman start`

### Run tests
- `$ rake minitest` to run all Ruby tests.
- `$ rake minitest:<type>` to run just tests of that type. Use `:models`, `:controllers`, `:helpers`, `:services`, `:features` etc.
- `$ rake teaspoon` to run JavaScript tests.

Note that you need to have phantomjs installed (`$ brew install phantomjs`) to run the JavaScript tests.

## Deploying on Heroku

The demo is hosted on [Heroku](http://heroku.com) so that's the recommended place. You'll need to install Pusher and Mandrill to get it fully functional.