class CreateTimeMeasures < ActiveRecord::Migration
  def change
    create_table :time_measures do |t|
			t.integer :time
			t.float :temp
			t.float :ph
			t.belongs_to :process_record
    end
  end
end
