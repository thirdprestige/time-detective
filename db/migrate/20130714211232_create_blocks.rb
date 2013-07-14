class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.text :content
      t.integer :order

      t.timestamps
    end
  end
end
