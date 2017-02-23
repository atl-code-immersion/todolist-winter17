class AddValueToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :dl_dt, :datetime
  end
end
