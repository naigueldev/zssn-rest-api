class CreateSurvivors < ActiveRecord::Migration
  def change
    create_table :survivors do |t|
      t.string :name
      t.integer :age
      t.string :gender, limit: 1
      t.float :latitude
      t.float :longitude
      t.integer :contamination_count, default: 0

      t.timestamps null: false
    end
  end
end
