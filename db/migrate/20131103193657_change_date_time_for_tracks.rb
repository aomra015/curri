class ChangeDateTimeForTracks < ActiveRecord::Migration
  def change
    remove_column :tracks, :start_date
    remove_column :tracks, :start_time
    remove_column :tracks, :end_date
    remove_column :tracks, :end_time

    add_column :tracks, :start_time, :datetime
    add_column :tracks, :end_time, :datetime
  end
end
