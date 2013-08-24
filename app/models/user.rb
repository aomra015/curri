class User < ActiveRecord::Base
  belongs_to :classrole, polymorphic: true

  has_secure_password

  delegate :classrooms, to: :classrole

  def add_default_classroom
    self.classrooms.create(name: "Curry Classroom")

    default_classroom = self.classrooms.find_by(name: "Curry Classroom")

    js_track = default_classroom.tracks.create(name: "jQuery UI Autocomplete")
    api_track = default_classroom.tracks.create(name: "API Building")

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
  end
end
