class AddPublishedToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :published, :boolean, default: false
    Track.all.each do |track|
      track.published = true
      track.save
    end
  end
end
