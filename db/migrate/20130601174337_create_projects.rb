class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.boolean :active, default: true, null: false
      t.string :name

      t.references :account, null: false

      t.timestamps
    end

    create_table :project_activities do |t|
      t.references :project, null: false
      t.references :project_time_entry
      t.references :worker, null: false

      t.timestamps
    end

    create_table :project_identities do |t|
      t.references :project, null: false
      t.string :identifier, null: false

      t.timestamps
    end

    create_table :project_time_entries do |t|
      t.references :project, null: false
      t.references :worker, null: false

      t.float :hours, default: 0.0, null: false
      t.text :description
      t.string :state, default: 'pending', null: false

      t.timestamps
    end
  end
end
