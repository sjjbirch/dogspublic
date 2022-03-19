class ApplicationController < ActionController::Base

    def god_skip
        unless admin_signed_in?
          authenticate_user!
        end
    end

end
