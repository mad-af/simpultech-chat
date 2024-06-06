class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.text :message
      t.string :created_by
      # t.datetime :created_at

      t.timestamps
    end
  end
end
