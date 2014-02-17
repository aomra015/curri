require 'test_helper'

class InvitationsCreatorTest < ActiveSupport::TestCase
  before do
    valid_emails = 'test1@gmail.com, test2@gmail.com, test3@gmail.com'
    @valid_invitation_creator = InvitationCreator.new(valid_emails, classrooms(:one))
    invalid_emails = 'test1@gmail.com, test2@gmail.com test3@gmail.com'
    @invalid_invitation_creator = InvitationCreator.new(invalid_emails, classrooms(:one))
  end

  test "email string is split into array" do
    assert_equal ['test1@gmail.com', 'test2@gmail.com', 'test3@gmail.com'], @valid_invitation_creator.emails
  end

  test "valid email inputs returns true when validated" do
    assert_equal true, @valid_invitation_creator.valid?
  end

  test "invalid email inputs returns false when validated" do
    assert_equal false, @invalid_invitation_creator.valid?
  end

  test "with valid emails invitations are created" do
    assert_difference 'Invitation.count', @valid_invitation_creator.emails.length do
        @valid_invitation_creator.save
      end
  end

  test "with valid emails the save method returns true" do
    assert_equal true, @valid_invitation_creator.save
  end

  test "with invalid emails invitations are not created" do
    assert_difference 'Invitation.count', 0 do
        @invalid_invitation_creator.save
      end
  end

  test "with invalid emails the save method returns false" do
    assert_equal false, @invalid_invitation_creator.save
  end

  test "with valid emails invitations should be emailed" do
    @valid_invitation_creator.save

    assert_equal [@valid_invitation_creator.emails.length, 0], Delayed::Worker.new.work_off
  end
end