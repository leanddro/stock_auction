class AddBatchToItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :batch, null: true, foreign_key: true
  end
end
