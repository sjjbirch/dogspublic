class DashboardController < ApplicationController
  before_action :authenticate_admin!

  def tools
  end

  def list_all_users
    @users = User.all
  end

  def banhammer
    @user = User.find(params[:id])
    banner(@user)
    undogger(@user)
    hammerflasher(@user)
    redirect_to userlist_path
  end

  def banner(user)
    user.toggle(:banned).save
  end

  def undogger(user)
    user.dogs.each do | dog |
      dog.advert.try(:destroy)
    end
  end

  def hammerflasher(user)
    @user.banned? ? (flash[:success] = "User B&") : (flash[:success] = "User unB&")
  end

  def list_all_dogs
    @dogs = Dog.all
  end

end
