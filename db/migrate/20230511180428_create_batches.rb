class CreateBatches < ActiveRecord::Migration[7.0]
  def change
    create_table :batches do |t|
      t.string :code, limit: 9
      t.datetime :start_at
      t.datetime :end_at
      t.integer :minimum_bid
      t.integer :minimum_bid_diference
      t.integer :status, default: 1
      t.references :create_by, references: :users, null: false, foreign_key: { to_table: :users}
      t.references :approved_by, references: :users, null: true, foreign_key: { to_table: :users}
      t.references :winner, references: :users, null: true, foreign_key: { to_table: :users}

      t.timestamps
    end
    add_index :batches, :code, unique: true
  end
end
