class AdminController < Super::ApplicationController
  before_action :reset_database

  private

  def reset_database
    ResetJob.perform_later
  end
end
