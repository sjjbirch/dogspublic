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
      flash[:success] = "User deleted"
      redirect_to dogs_path
    else
      flash[:success] = "Dog deletion failed"
      render 'index'
    end
  end

end
