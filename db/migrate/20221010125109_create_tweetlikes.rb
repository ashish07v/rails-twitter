class CreateTweetlikes < ActiveRecord::Migration[5.2]
  def change
    create_table :tweetlikes do |t|

      t.timestamps
    end
  end
end
