module ClassroomsHelper

  def pending_invitations(pending, accepted)
    if pending != 0
      content_tag :div, "#{pending} #{'invitation'.pluralize(pending)} pending", class: 'pending-inv h5'
    elsif accepted != 0
      content_tag :div, '0 invitations pending', class: 'no-pending-inv h5'
    end
  end
end
