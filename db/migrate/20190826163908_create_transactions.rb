class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.money :amount, default: 0
      t.string :country
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
