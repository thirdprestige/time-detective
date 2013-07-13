class AddIntegrationToProjectIdentities < ActiveRecord::Migration
  def change
    add_column :project_identities, :integration, :string
  end
end
