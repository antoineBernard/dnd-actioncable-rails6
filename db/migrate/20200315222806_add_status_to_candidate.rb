class AddStatusToCandidate < ActiveRecord::Migration[6.0]
  def change
    add_column :candidates, :status, :string, default: 'to_meet'
  end
end
