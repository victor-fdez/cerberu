class CreateCheeses < ActiveRecord::Migration
  def change
    create_table :cheeses do |t|
			t.string :name
      t.text :about
      t.timestamps
    end
  end
end
