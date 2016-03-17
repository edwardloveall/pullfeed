class CreateRepositoryFetches < ActiveRecord::Migration
  def change
    create_table :repository_fetches do |t|
      t.timestamps null: false
      t.string :owner
      t.string :repo
    end
  end
end
