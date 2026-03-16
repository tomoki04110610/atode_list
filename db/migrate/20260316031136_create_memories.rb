class CreateMemories < ActiveRecord::Migration[7.2]
  def change
    create_table :memories do |t|
      t.string :content, null: false
      t.integer :status, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.datetime :completed_at

      t.timestamps
    end
  end
end
