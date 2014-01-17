module ClassroomsHelper

  def pending_invitations(pending, accepted)
    if pending != 0
      content_tag :div, "#{pending} #{'invitation'.pluralize(pending)} pending", class: 'pending-inv h5'
    elsif accepted != 0
      content_tag :div, '0 invitations pending', class: 'no-pending-inv h5'
    end
  end

  def unpublished_tracks(unpublished, published)
    if unpublished != 0
      content_tag :div, "#{unpublished} #{'track'.pluralize(unpublished)} unpublished", class: 'unpublished-tracks h5'
    elsif published != 0
      content_tag :div, '0 tracks unpublished', class: 'all-published h5'
    end
  end
end
