class ChangeDateTimeForTracks < ActiveRecord::Migration
  def change
    change_column :tracks, :start_date, :datetime
    change_column :tracks, :start_time, :datetime
    change_column :tracks, :end_date, :datetime
    change_column :tracks, :end_time, :datetime
  end
end
