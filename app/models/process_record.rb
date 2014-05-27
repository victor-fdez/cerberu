class ProcessRecord < ActiveRecord::Base
				belongs_to :process_type
				has_many :time_measures
				belongs_to :cheese
				accepts_nested_attributes_for :process_type, :reject_if => lambda { |pt| pt.blank? }
				accepts_nested_attributes_for :time_measures, :allow_destroy => true
end
