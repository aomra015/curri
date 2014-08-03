class AddPublishedToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :published, :boolean, default: false
  end
end
