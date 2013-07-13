class AddFieldsToProjectActivities < ActiveRecord::Migration
  def change
    add_column :project_activities, :type, :string
    add_column :project_activities, :external_identifier, :text
  end
end
