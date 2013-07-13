class CreateIntegrations < ActiveRecord::Migration
  def change
    create_table :integrations do |t|
      t.references :account
      t.string :type
      t.text :secret_encrypted

      t.timestamps
    end
  end
end
