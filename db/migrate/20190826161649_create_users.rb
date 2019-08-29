class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :country
      t.date   :date_of_birth
      t.integer :loyalty_points, default: 0
      t.references :tier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
