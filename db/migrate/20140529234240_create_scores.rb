class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.datetime :start_date
      t.string :team_top
      t.string :team_bottom
      t.integer :t1
      t.integer :b1
      t.integer :t2
      t.integer :b2
      t.integer :t3
      t.integer :b3
      t.integer :t4
      t.integer :b4
      t.integer :t5
      t.integer :b5
      t.integer :t6
      t.integer :b6
      t.integer :t7
      t.integer :b7
      t.integer :t8
      t.integer :b8
      t.integer :t9
      t.integer :b9
      t.boolean :end
      t.integer :user_id

      t.timestamps
    end
    add_index :scores, [:user_id, :created_at]
  end
end
