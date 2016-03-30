class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.timestamps null: false

      t.integer :number_of_subscribers
      t.string :repository, index: true
      t.string :subscriber
    end
  end
end
