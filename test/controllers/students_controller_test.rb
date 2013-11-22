require 'test_helper'

class StudentsControllerTest < ActionController::TestCase

  before do
    session[:user_id] = users(:student).id
  end

  test "student should be able to toggle status" do
    @request.env['HTTP_REFERER'] = classrooms_url
    assert_equal false, students(:student1).help

    patch :update_status
    student = Student.find(students(:student1).id)
    assert_equal true, student.help
    assert_redirected_to :back
  end

  test "action redirects to some default url if referer is missing" do
    patch :update_status
    assert_redirected_to classrooms_path
  end

end