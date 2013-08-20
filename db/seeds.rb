# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

js_track = Track.create(name: "jQuery UI Autocomplete")
api_track = Track.create(name: "API Building")

js_track.checkpoints.create([
  {content: "Installing a JS library"},
  {content: "Selecting elements"},
  {content: "Using jQuery UI widgets"},
  {content: "Using an array source for autocomplete"},
  {content: "Using a remote source for autocomplete"},
  {content: "Using a remote function source for autocomplete"},
  {content: "Sending Ajax requests"},
  {content: "Parsing JSON results"}
  ])

api_track.checkpoints.create([
  {content: "What are formats?"},
  {content: "What is JSON?"},
  {content: "How to request a specific a format"},
  {content: "respond_with"},
  {content: "respond_to"}
  ])


