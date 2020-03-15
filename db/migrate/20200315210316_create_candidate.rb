class CreateCandidate < ActiveRecord::Migration[6.0]
  def change
    create_table :candidates do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :role
      t.float :score
      t.integer :likes
    end
  end
end
