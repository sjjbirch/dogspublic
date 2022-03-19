class StaticPagesController < ApplicationController
  
  def redirecter
    flash[:success] = "These pages were just left here because the nav bar 
    looked empty without them! Pretend you never clicked on it."
    redirect_to root_path
  end

  def home
  end

  def about
    redirecter
  end

  def general_contact
    redirecter
  end

  def information
    redirecter
  end
end
