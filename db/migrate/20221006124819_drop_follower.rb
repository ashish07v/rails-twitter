class DropFollower < ActiveRecord::Migration[5.2]
  def change
    drop_table :follower
  end
end
