class DropProteinsTable < ActiveRecord::Migration
  def up
    drop_table :proteins
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end





class CreateProteins < ActiveRecord::Migration
  def change
    create_table :proteins do |t|
      t.string :name
      t.string :accession_number
      t.string :sequence
      t.string :weight
      t.string :iso_point

      t.timestamps null: false
    end
  end
end
