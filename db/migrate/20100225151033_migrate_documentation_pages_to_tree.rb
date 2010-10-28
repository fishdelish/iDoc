class MigrateDocumentationPagesToTree < ActiveRecord::Migration
  def self.up
    add_column :documentation_pages, :parent_id, :integer
    add_column :documentation_pages, :position, :integer

    execute("ALTER TABLE documentation_pages ADD CONSTRAINT documentation_pages_parent_id_key UNIQUE(parent_id, position)")
  end

  def self.down
    remove_column :documentation_pages, :parent_id
    remove_column :documentation_pages, :position

  end
end
