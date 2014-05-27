class TimeMeasure < ActiveRecord::Base
		belongs_to :process_record
		validates :temp, numericality: { greater_than_or_equal_to: -459.67 }
		validates :ph, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 14 }
		validates :time, numericality: { only_integer: true }
end
