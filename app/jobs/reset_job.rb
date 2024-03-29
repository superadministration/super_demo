class ResetJob < ApplicationJob
  queue_as :default

  def perform
    previous = ResetRun.last&.created_at || 1.hour.ago

    if (Time.now - previous) > 5.minutes
      ResetRun.create!
      ResetRun.reset
    end
  rescue
  end
end
