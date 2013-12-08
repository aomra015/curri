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
- `$ rake test`

### Better Errors
- This app uses the gem 'better_errors' to get much more useful errors in development.
- The [Rails Panel](https://chrome.google.com/webstore/detail/railspanel/gjpfobpafnhjhbajcjgccbbdofdckggg) chrome extension allows us to see useful information for every request (like controller, action, DB queries, errors, etc.). It's optional but recommended.

### Rails Best Practices
From the command line run `$ rails_best_practices -f html` to have the code reviewed. You should see a file called `rails_best_practices_output.html` with some suggestions for refactoring.

### Improving Database queries
In development we have the "bullet" gem enabled. It will print suggestions to the browser's console. Open the "Uniform Notifier" object to see the suggestion for improving the query on the page.