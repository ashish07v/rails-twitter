class CreateTopicFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :topic_followers do |t|
      t.references :topic, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.timestamps
    end
  end
end
