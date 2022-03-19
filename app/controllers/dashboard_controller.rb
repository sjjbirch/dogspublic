class DashboardController < ApplicationController
  before_action :authenticate_admin!

  def tools
  end

  def list_all_users
    @users = User.all
  end

  def banhammer
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "User B&"
      redirect_to userlist_path
    else
      flash[:success] = "Evaded"
      render :userlist
    end
  end

  def list_all_dogs
    @dogs = Dog.all
  end

end
