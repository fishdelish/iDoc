class MysparqlConfig < ActiveRecord::Migration
  def self.up
    add_column :site_configs, :mysparql_server, :string
  end

  def self.down
    remove_column :site_configs, :mysparql_server
  end
end
