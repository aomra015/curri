# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

js_track = Track.create(name: "JavaScript Basics")
jq_track = Track.create(name: "jQuery Basics")

js_track.checkpoints.create([
  {content: "What is Javascript & what is it used for?"},
  {content: "Client side vs. Server side"},
  {content: "Assigning variables"},
  {content: "Naming conventions for variables"},
  {content: "Using Variables"},
  {content: "Primitive types: Strings, Numbers, Booleans"},
  {content: "Object(the hash), Array(special case of object)"},
  {content: "Statements"},
  {content: "Defining functions/methods"},
  {content: "Calling functions/methods"},
  {content: "Flow Control (if statements)"},
  {content: "Looping (for, while)"}
  ])

jq_track.checkpoints.create([
  {content: "What is jQuery?"},
  {content: "Why use jQuery? (problems it solves)"},
  {content: "What is the DOM?"},
  {content: "Finding elements in the DOM"},
  {content: "Event binding (doing certain actions based on events, e.g., a mouse click)"},
  {content: "Creating an element (div, image, etc.)"},
  {content: "Changing the CSS of an element"},
  {content: "Adding classes to an element"},
  {content: "Hiding and showing elements"},
  {content: "Appending html/text to an element"},
  {content: "Appending an element to another"}
  ])


