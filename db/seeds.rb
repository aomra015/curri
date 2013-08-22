# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

test_classroom = Classroom.create(name: "Curry Classroom")

js_track = test_classroom.tracks.create(name: "jQuery UI Autocomplete")
api_track = test_classroom.tracks.create(name: "API Building")

js_track.checkpoints.create([
  {expectation: "Installing a JS library"},
  {expectation: "Selecting elements"},
  {expectation: "Using jQuery UI widgets"},
  {expectation: "Using an array source for autocomplete"},
  {expectation: "Using a remote source for autocomplete"},
  {expectation: "Using a remote function source for autocomplete"},
  {expectation: "Sending Ajax requests"},
  {expectation: "Parsing JSON results"}
  ])

api_track.checkpoints.create([
  {expectation: "What are formats?"},
  {expectation: "What is JSON?"},
  {expectation: "How to request a specific a format"},
  {expectation: "respond_with"},
  {expectation: "respond_to"}
  ])


