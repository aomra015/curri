class RenameConentForCheckpoints < ActiveRecord::Migration
  def change
    rename_column :checkpoints, :content, :expectation
  end
end
