class AddNoteToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :note, :text
  end
end
