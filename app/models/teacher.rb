class Teacher < ActiveRecord::Base
  has_one :user, as: :classrole, dependent: :destroy
  has_many :classrooms

  delegate :email, to: :user

  after_create :add_default_classroom


  def add_default_classroom
    self.classrooms.create(name: "Sample Classroom")

    default_classroom = self.classrooms.find_by(name: "Sample Classroom")

    js_track = default_classroom.tracks.create(name: "Beginner JavaScript")
    jq_track = default_classroom.tracks.create(name: "Beginner jQuery")

    js_track.checkpoints.create([
      {expectation: "JavaScript & its uses", success_criteria: "JavaScript is a programming language used mainly for interactivity on web browsers."},
      {expectation: "Client side vs. Server side", success_criteria: "Client-side code runs on the user's web browser (e.g., JavaScript). Server-side code (e.g., Ruby) runs on the server that hosts the website."},
      {expectation: "Assigning variables", success_criteria: "var myName = 'Homer Simpson'"},
      {expectation: "Naming conventions for variables", success_criteria: "UPPERCASE for constants. Capitalize constructors or classes. camelCase variables."},
      {expectation: "Using Variables", success_criteria: "myName + ' has hair' returns 'Homer Simpson has hair'"},
      {expectation: "Primitive types", success_criteria: "var myName = 'Homer Simpson'"},
      {expectation: "Objects (hash)", success_criteria: "{ apples: 3, trees: 1, physicist: 'Newton' }"},
      {expectation: "Arrays", success_criteria: "Special case of object. ['meaning', 'of', 'life', 42]"},
      {expectation: "Statements", success_criteria:  "var x = 55 + 'hello'.length;"},
      {expectation: "Defining functions/methods", success_criteria:  "function sayHiTo(name) { return 'Hi ' + name + '!'; };"},
      {expectation: "Calling functions/methods", success_criteria:  "sayHiTo('Chuck') will return 'Hi Chuck!'"},
      {expectation: "Flow Control (if statements)", success_criteria:  "if (sky === 'blue' ) { return 'It's a nice day'; }"},
      {expectation: "Looping (for, while)", success_criteria: "for (var i = 0; i < 4; i++) { console.log('Winning'); }"}])

    jq_track.checkpoints.create([
      {expectation: "jQuery & its uses", success_criteria: "A JavaScript library for cross-browser html document traversal and manipulation, event handling, ajax, animation, etc."},
      {expectation: "DOM", success_criteria: "The Document Object Model is an API for valid HTML documents. It essentially connects web pages to scripts like jQuery."},
      {expectation: "Finding elements in the DOM", success_criteria: "$( 'div' ), $( '.className' ), $( '#idName' )"},
      {expectation: "Event binding", success_criteria: "$( '.action' ).on( 'click', function(event) { alert( 'You Clicked Something!' ); });"},
      {expectation: "Creating an element", success_criteria: "$( '<div>' );"},
      {expectation: "Changing the CSS of an element", success_criteria: "$( 'div' ).css( 'background-color', 'purple' );"},
      {expectation: "Adding classes to an element", success_criteria: "$( '.link' ).addClass( 'blink' );"},
      {expectation: "Hiding and showing elements", success_criteria: "$( '#cart' ).hide(); $( '#invoice' ).show();"},
      {expectation: "Appending html/text to an element", success_criteria: "$( '.item' ).append( '<p>Sold out!</p>' );"},
      {expectation: "Appending an element to another", success_criteria: "$( '.buy-button' ).appendTo( '.item' )"}
      ])
  end

end
