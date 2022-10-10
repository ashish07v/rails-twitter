class CreateTweetlikes < ActiveRecord::Migration[5.2]
  def change
    create_table :tweetlikes do |t|
      t.integer :likes
      t.references :tweet, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
