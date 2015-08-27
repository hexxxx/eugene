class Protein < ActiveRecord::Base
  # attr_accessor :name, :accession_number, :sequence

  validates :name, presence: true
end
