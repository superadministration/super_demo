class CreateResetRuns < ActiveRecord::Migration[7.0]
  def change
    create_table :reset_runs do |t|

      t.timestamps
    end
  end
end
