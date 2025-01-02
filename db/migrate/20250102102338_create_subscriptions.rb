class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.decimal :price
      t.string :billing_frequency
      t.datetime :started_at
      t.datetime :expires_at

      t.timestamps
    end
  end
end
