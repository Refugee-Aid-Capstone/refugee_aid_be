class AidRequest < ApplicationRecord
  belongs_to :organization
  validates :aid_type, :description, :status, presence: true

  enum status: [:active, :pending, :fulfilled]
end
