class Cheese < ActiveRecord::Base
				has_many :process_records, :dependent => :destroy
				accepts_nested_attributes_for :process_records, :allow_destroy => true
end
