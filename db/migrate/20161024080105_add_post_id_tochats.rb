class AddPostIdTochats < ActiveRecord::Migration[5.0]
  def change
    add_column :chats, :postid, :integer
  end
end
