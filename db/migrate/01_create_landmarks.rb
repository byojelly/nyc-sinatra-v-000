class CreateLandmarks < ActiveRecord::Migration[5.1]
  create_table :landmarks do |f|
    f.string :name
    f.integer :figure_id
    f.integer :year_completed
  end
end
