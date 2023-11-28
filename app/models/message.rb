class Message < ApplicationRecord
  belongs_to :volunteer
  belongs_to :organization

  enum sender: [:volunteer, :organization]
  validates_presence_of :message_body, :sender

  def sent_by 
    if sender == "organization"
      organization
    elsif sender == "volunteer"
      volunteer
    end
  end

  def recipient
    if sender == "organization"
      volunteer
    elsif sender == "volunteer"
      organization
    end
  end
end
