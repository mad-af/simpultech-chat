class Chat < ApplicationRecord
  after_create_commit { broadcast_message }

  private

  def broadcast_message
    ActionCable.server.broadcast("ChatChannel", {
      id:, message:, created_by:
    })
  end
end
