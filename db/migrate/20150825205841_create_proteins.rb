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
