class AddUseToDataFile < ActiveRecord::Migration
  def self.up
  add_column :data_files, :use, :boolean
    
  end

  def self.down
    remove_column :data_files, :use
    
  end
end
