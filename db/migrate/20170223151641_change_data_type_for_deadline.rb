class ChangeDataTypeForDeadline < ActiveRecord::Migration[5.0]
  def change
  	change_column :tasks, :deadline, :string
  end
end
