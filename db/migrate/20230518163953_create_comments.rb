class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :batch, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :parent, references: :comments, null: true, foreign_key: { to_table: :comments }

      t.timestamps
    end
  end
end
