class CreateIncidents < ActiveRecord::Migration[8.1]
  def change
    create_table :incidents do |t|
      t.string :title, null: false
      t.text :description
      t.integer :status, null: false, default: 0
      t.integer :severity, null: false, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :incidents, :status
  end
end
