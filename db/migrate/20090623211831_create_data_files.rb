class CreateDataFiles < ActiveRecord::Migration
  def self.up
    create_table :data_files do |t|

     
    end
  end

  def self.down
    drop_table :data_files
  end
end
