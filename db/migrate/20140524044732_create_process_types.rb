class CreateProcessTypes < ActiveRecord::Migration
  def change
    create_table :process_types do |t|
      t.string :name
    end
  end
end
