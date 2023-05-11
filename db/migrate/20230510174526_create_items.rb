class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :code, limit: 10
      t.text :description
      t.float :weight
      t.float :width
      t.float :height
      t.float :depth
      t.integer :status
      t.references :create_by, references: :users, null: false, foreign_key: { to_table: :users}
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :items, :code, unique: true
  end
end
