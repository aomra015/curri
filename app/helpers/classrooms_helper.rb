module ClassroomsHelper

  def pending_invitations(pending, accepted)
    if pending != 0
      content_tag :div, "#{pending} #{'invitation'.pluralize(pending)} pending", class: 'pending-inv h6'
    elsif accepted != 0
      content_tag :div, '0 invitations pending', class: 'no-pending-inv h6'
    end
  end

  def unpublished_tracks(unpublished, published)
    if unpublished != 0
      content_tag :div, "#{unpublished} #{'track'.pluralize(unpublished)} unpublished", class: 'unpublished-tracks h6'
    elsif published != 0
      content_tag :div, '0 tracks unpublished', class: 'all-published h6'
    end
  end
end
