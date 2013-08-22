class AddReferenceToTrack < ActiveRecord::Migration
  def change
    add_reference :tracks, :classroom, index: true
  end
end
