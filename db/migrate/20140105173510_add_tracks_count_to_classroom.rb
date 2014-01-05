class AddTracksCountToClassroom < ActiveRecord::Migration
  def self.up
    add_column :classrooms, :tracks_count, :integer, :default => 0
      Classroom.reset_column_information
      Classroom.all.each do |p|
        p.update_attribute :tracks_count, p.tracks.length
      end
    end

    def self.down
      remove_column :classrooms, :tracks_count
    end
end
