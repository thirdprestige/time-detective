class CreateAccountings < ActiveRecord::Migration
  def change
    create_table :accountings do |t|
      t.references :account
      t.references :user

      t.timestamps
    end
  end
end
