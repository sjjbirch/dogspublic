class DashboardController < ApplicationController
  before_action :authenticate_admin!

  def tools
  end

end
