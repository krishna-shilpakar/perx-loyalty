class CreatePoints < ActiveRecord::Migration[6.0]
  def change
    create_table :points do |t|
      t.integer :num, default: 0
      t.references :users_reward, null: false, foreign_key: true

      t.timestamps
    end
  end
end
