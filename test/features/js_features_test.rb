require 'test_helper'

class JSFeaturesTest < Capybara::Rails::TestCase

  before do
    Capybara.current_driver = Capybara.javascript_driver
    teacher = users(:teacher1)
    login_as(teacher)
    @classroom = classrooms(:one)
  end

  test "a teacher can add a classroom" do
    click_link "Create Classroom"

    fill_in :classroom_name, with: "New classroom name"
    click_button 'Create Classroom'
    wait_for_ajax

    assert page.has_content?('New classroom name')
  end

  test "a teacher can join a classroom using token" do
    click_link "Join Classroom"

    fill_in :teacher_token, with: "ELtCtf7o"
    click_button 'Join Classroom'
    wait_for_ajax

    assert page.has_content?('New Classroom with token')
  end

  test "a teacher can add checkpoints to a track" do
    click_link @classroom.name

    @track = tracks(:one)
    click_link @track.name

    click_link 'Add Checkpoint'

    fill_in :checkpoint_expectation, with: 'New expectation'
    fill_in :checkpoint_success_criteria, with: 'New success criteria'
    click_button 'Create Checkpoint'
    wait_for_ajax

    checkpoint = Checkpoint.last
    within "#checkpoint_#{checkpoint.id}" do
        assert page.has_content?('New expectation')
        assert page.has_content?('New success criteria')
    end
  end
end