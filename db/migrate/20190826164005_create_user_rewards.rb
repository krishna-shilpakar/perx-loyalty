class CreateUserRewards < ActiveRecord::Migration[6.0]
  def change
    create_table :user_rewards do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true
      t.boolean :claimed, default: false
      t.jsonb :meta, null: false, default: '{}'
      t.text :comments

      t.timestamps
    end
  end
end
