class DogsController < ApplicationController
  # before_action :admin_signed_in?, only: [:destroy,:edit, :index]
  before_action :dog_god_skip, only: [:build, :destroy, :edit, :update, :index]
  before_action :ownership_filter, only: [:edit, :update, :destroy]

  def dog_params
    params.require(:dog).permit(  :rname, :cname,
                                  :dob,  :owner, :handler, 
                                  :sex )
  end
  
  def ownership_filter
    @dog = Dog.find(params[:id])
    unless admin_signed_in? || current_user.id == @dog.user.id
        flash[:success] = "You can't do that unless you own it."
        redirect_to dogs_path
    end
  end

  def dog_god_skip
    unless admin_signed_in?
      authenticate_user!
    end
  end 

  def index
      @dogs = current_user.dogs.all
  end

 
  def show
    @dog = Dog.find(params[:id])
  end
  
  def new
    @dog = Dog.new
  end

  def build
  end

  def create
    @dog = current_user.dogs.build(dog_params)
    if @dog.save
      flash[:success] = "Dog created"
      redirect_to dogs_path
    else
      # come back to
      flash[:success] = "Dog creation failed"
      render 'new'
    end
  end

  def edit
    @dog = Dog.find(params[:id])
  end

  def update
    @dog = Dog.find(params[:id])
    if @dog.update(dog_params)
      flash[:success] = "Dog updated"
      redirect_to @dog
    else
      flash[:success] = "Dog update failed"
      render :edit
    end
  end

  def destroy
    @dog = Dog.find(params[:id])
    if @dog.destroy
      flash[:success] = "Dog deleted"
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "Dog deletion failed"
      render 'index'
    end
  end

end
