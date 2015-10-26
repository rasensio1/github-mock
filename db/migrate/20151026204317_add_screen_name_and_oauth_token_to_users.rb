class AddScreenNameAndOauthTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :screen_name, :string
    add_column :users, :oauth_token, :string
  end
end
