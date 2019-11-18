class DropProfiles < ActiveRecord::Migration[5.2]
  def up
    drop_table :profiles 
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
