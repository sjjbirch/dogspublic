class ApplicationController < ActionController::Base
  before_action :is_banned?

  def is_banned?
    if current_user.present? && current_user.banned
      # query the database if someone's logged on to see if they've been the victim of badmin boolean abuse
      sign_out current_user
      flash[:danger] = "This account has been suspended...."
      root_path
    end
  end

    def god_skip
        unless admin_signed_in?
          authenticate_user!
        end
    end
    

end
