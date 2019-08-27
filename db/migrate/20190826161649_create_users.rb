class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :country
      t.integer :loyalty_points, default: 0

      t.timestamps
    end
  end
end
