class CreateFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :followers do |t|
      t.integer :following_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
