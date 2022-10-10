class ChangePasswordDigestToBeDigestInUsers < ActiveRecord::Migration[5.2]
  def change
      add_column :users, :password, :digest
  end
end
