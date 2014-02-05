class AddAuthTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_token, :string

    User.all.each do |user|
      user.generate_token(:auth_token)
      user.save
    end
  end
end
