class AddSuccessCriteriaToCheckpoints < ActiveRecord::Migration
  def change
    add_column :checkpoints, :success_criteria, :string
  end
end
