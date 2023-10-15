class AidRequest < ApplicationRecord
  belongs_to :organization
  validates :aid_type, :description, :status, presence: true

  enum aid_type: [:medical, :language, :food, :legal, :other]
  enum status: [:active, :pending, :fulfilled]
end
