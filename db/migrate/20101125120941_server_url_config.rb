class ServerUrlConfig < ActiveRecord::Migration
  def self.up
    add_column :site_configs, :server_url, :string
  end

  def self.down
    remove_column :site_configs, :server_url
  end
end
