class AddDefaultValueToRequesters < ActiveRecord::Migration
  def change
    change_column :requesters, :help, :boolean, default: false
  end
end
