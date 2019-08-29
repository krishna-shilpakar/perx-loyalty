class CreateTiers < ActiveRecord::Migration[6.0]
  def change
    create_table :tiers do |t|
      t.string :name

      t.timestamps
    end
  end
end
