class ProcessType < ActiveRecord::Base
	validates :name, presence: true
	has_many :process_records
end
