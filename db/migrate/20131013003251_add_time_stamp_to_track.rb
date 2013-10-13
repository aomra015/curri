class AddTimeStampToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :start_date, :date
    add_column :tracks, :start_time, :time
    add_column :tracks, :end_date, :date
    add_column :tracks, :end_time, :time
  end
end
