class RemoveStartEndDateFromTrack < ActiveRecord::Migration
  def change
    remove_column :tracks, :start_date
    remove_column :tracks, :end_date
  end
end
