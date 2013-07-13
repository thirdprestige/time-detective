class AddConfirmationToAccountings < ActiveRecord::Migration
  def change
    add_column :accountings, :confirmed_at, :datetime
  end
end
