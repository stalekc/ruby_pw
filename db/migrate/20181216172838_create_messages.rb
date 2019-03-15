class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    drop_table :messages
    create_table :messages do |t|
      t.text :text

      t.timestamps
    end
    add_reference :messages, :user, foreign_key: true
    add_reference :messages, :forum, foreign_key: true
  end
end
