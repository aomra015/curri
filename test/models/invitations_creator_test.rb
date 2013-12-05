require 'test_helper'

class InvitationsCreatorTest < ActiveSupport::TestCase
  before do
    @valid_emails = 'test1@gmail.com, test2@gmail.com, test3@gmail.com'
    @invalid_emails = 'test1@gmail.com, test2@gmail.com test3@gmail.com'
    @classroom = classrooms(:one)
  end

  test "email string is split into array" do
    invitation_creator = InvitationCreator.new(@valid_emails, @classroom)

    assert_equal ['test1@gmail.com', 'test2@gmail.com', 'test3@gmail.com'], invitation_creator.emails
  end

  test "valid email inputs returns true when validated" do
    invitation_creator = InvitationCreator.new(@valid_emails, @classroom)

    assert_equal true, invitation_creator.valid?
  end

  test "invalid email inputs returns false when validated" do
    invitation_creator = InvitationCreator.new(@invalid_emails, @classroom)

    assert_equal false, invitation_creator.valid?
  end

  test "with valid emails invitations are created" do
    invitation_creator = InvitationCreator.new(@valid_emails, @classroom)
    assert_difference 'Invitation.count', invitation_creator.emails.length do
        invitation_creator.save
      end
  end

  test "with valid emails the save method returns true" do
    invitation_creator = InvitationCreator.new(@valid_emails, @classroom)
    assert_equal true, invitation_creator.save
  end

  test "with invalid emails invitations are not created" do
    invitation_creator = InvitationCreator.new(@invalid_emails, @classroom)
    assert_difference 'Invitation.count', 0 do
        invitation_creator.save
      end
  end

  test "with ivalid emails the save method returns false" do
    invitation_creator = InvitationCreator.new(@invalid_emails, @classroom)
    assert_equal false, invitation_creator.save
  end

  test "with valid emails invitations should be emailed" do
    invitation_creator = InvitationCreator.new(@valid_emails, @classroom)

    ActionMailer::Base.deliveries.clear
    invitation_creator.save

    assert_equal invitation_creator.emails.length, ActionMailer::Base.deliveries.length
  end
end