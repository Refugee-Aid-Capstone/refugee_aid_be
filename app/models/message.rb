class Message < ApplicationRecord
  belongs_to :volunteer
  belongs_to :organization

  enum sender: [:volunteer, :organization]
  validates_presence_of :message_body, :sender
end
