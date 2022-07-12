class AddScoreTypeToTarget < ActiveRecord::Migration[6.1]
  def change
    add_column :targets, :score_type, :string, default: "float"
  end
end
