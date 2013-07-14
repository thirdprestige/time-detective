class RenameBlockOrderToPosition < ActiveRecord::Migration
  def change
    rename_column :blocks, :order, :position
  end
end
