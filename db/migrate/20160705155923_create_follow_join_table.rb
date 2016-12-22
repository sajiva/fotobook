class CreateFollowJoinTable < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :following_id
      t.integer :follower_id

      t.timestamps null: false
    end

    add_index :follows, :following_id
    add_index :follows, :follower_id
  end
end
