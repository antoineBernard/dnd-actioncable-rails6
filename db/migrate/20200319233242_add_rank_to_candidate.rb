class AddRankToCandidate < ActiveRecord::Migration[6.0]
  def change
    add_column :candidates, :rank, :integer
  end
end
