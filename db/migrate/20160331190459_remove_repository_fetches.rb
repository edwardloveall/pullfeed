class RemoveRepositoryFetches < ActiveRecord::Migration
  def change
    drop_table :repository_fetches do |t|
      t.timestamps null: false
      t.string :owner
      t.string :repo
    end
  end
end
