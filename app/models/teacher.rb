class Teacher < ActiveRecord::Base
  has_one :user, as: :classrole, dependent: :destroy
  has_many :classrooms

  delegate :username, :email, to: :user

  after_create :add_default_classroom


  def add_default_classroom
    self.classrooms.create(name: "Sample Classroom")

    default_classroom = self.classrooms.find_by(name: "Sample Classroom")

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
