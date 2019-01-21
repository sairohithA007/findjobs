class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.integer :sender
      t.integer :recipient
      t.text :content

      t.timestamps
    end
  end
end
