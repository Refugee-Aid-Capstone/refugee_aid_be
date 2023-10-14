class AidRequest < ApplicationRecord
  belongs_to :organization

  enum aid_type: [:medical, :food, :shelter, :other]
end
