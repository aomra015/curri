class InvitationCreator

  attr_accessor :emails
  attr_accessor :invitations

  def initialize(emails, classroom)
    @classroom = classroom
    @emails = emails.split(/,|\n/).map!(&:strip)
    @invitations = []
  end

  def valid?
    emails.each do |email|
      invitation = Invitation.new(email: email)
      invitation.classroom = @classroom
      if invitation.invalid?
        return false
      else
        invitations << invitation
      end
    end

    return true
  end

  def save
    if valid?
      invitations.each do |inv|
        inv.save
        InvitationMailer.invite(inv).deliver
      end
      return true
    else
      return false
    end
  end

end