class DogsController < ApplicationController
  # before_action :admin_signed_in?, only: [:destroy,:edit, :index]
  before_action :god_skip, only: [:build, :destroy, :edit, :update, :index]
  before_action :dog_instancer, only: [ :dog_ownership_filter, :show, :edit,
                                        :update, :destroy ]
  before_action :dog_ownership_filter, only: [:edit, :update, :destroy]

  def dog_instancer
    @dog = Dog.find(params[:id])
  end

  def dog_params
    params.require(:dog).permit(  :rname, :cname,
                                  :dob,  :owner, :handler, 
                                  :sex )
  end
  
  def dog_ownership_filter
    unless admin_signed_in? || current_user.id == @dog.user.id
        flash[:danger] = "You can't do that unless you own it."
        redirect_to dogs_path
    end
  end

  def index
      @dogs = current_user.dogs.all
  end

 
  def show
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
      flash[:warning] = "Dog creation failed"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @dog.update(dog_params)
      flash[:success] = "Dog updated"
      redirect_to @dog
    else
      flash[:warning] = "Dog update failed"
      render :edit
    end
  end

  def destroy
    if @dog.destroy
      flash[:success] = "Dog deleted"
      redirect_back(fallback_location: root_path)
    else
      flash[:warning] = "Dog deletion failed"
      render 'index'
    end
  end

end
