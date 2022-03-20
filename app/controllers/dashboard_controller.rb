class DashboardController < ApplicationController
  before_action :authenticate_admin!

  def tools
  end

  def list_all_users
    @users = User.sophisticated_demonstration_of_scope_extension_and_database_querying
    # query the database through a scope with some eager loading to get only the most useful ascending order for a view
    # What order is that? The number of dogs they own.
  end

  def banhammer
    @user = User.find(params[:id])
    # select a victim from params and instance them
    banner(@user)
    undogger(@user)
    hammerflasher(@user)
    # how good is this object orientation
    redirect_to userlist_path
  end

  def banner(user)
    user.toggle(:banned).save
    # It would have been more thematically appropriate to use the unsafe toggle! method here, but we do it safely with save to trigger safety checks because we're boring
  end

  def undogger(user)
    user.dogs.each do | dog |
      dog.advert.try(:destroy)
    end
    # Banned people aren't allowed to have ads, so we destroy their ads. Just be thankful we leave your dogs.
  end

  def hammerflasher(user)
    @user.banned? ? (flash[:success] = "User B&") : (flash[:success] = "User unB&")
  end

  def list_all_dogs
    @dogs = Dog.all
    # get all the dogs from the database
  end

end
