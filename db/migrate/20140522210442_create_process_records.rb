class CreateProcessRecords < ActiveRecord::Migration
  def change
    create_table :process_records do |t|
			t.text :notes
			t.integer :cheese_id
			t.belongs_to :process_type
    end
  end
end
