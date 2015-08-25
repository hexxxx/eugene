class DropProteinsTable < ActiveRecord::Migration
  def up
    drop_table :proteins
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
