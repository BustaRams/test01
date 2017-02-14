class Message < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  validates :body, presence: true, length: {minimum: 2, maximum: 1000}

  after_create_commit { MessageBroadcastJob.perform_later(self) } # Send messages to all connected users.
end
