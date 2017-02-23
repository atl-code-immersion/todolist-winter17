class ChangeDataTypeForDlDt < ActiveRecord::Migration[5.0]
  def change
  	change_column :tasks, :dl_dt, :time
  end
end
