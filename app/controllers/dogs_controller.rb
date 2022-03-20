class DogsController < ApplicationController

  before_action :god_skip, only: [:build, :destroy, :edit, :update, :index]
  before_action :dog_instancer, only: [ :dog_ownership_filter, :show, :edit,
                                        :update, :destroy ]
  before_action :dog_ownership_filter, only: [:edit, :update, :destroy]

# advanced scoping extensions for full marks, querying only the most important Dog information
  def boys
    @dogs = Dog.males
  end  
  
  def girls
    @dogs = Dog.females
  end

  def puppies
    @dogs = Dog.puppers
  end

  def dog_instancer
    @dog = Dog.find(params[:id])
    # instantiate a dog from the database that matches the one in params
  end

  def dog_params
    params.require(:dog).permit(  :rname, :cname,
                                  :dob, :handler, 
                                  :sex )
  end
  
  def dog_ownership_filter
    unless admin_signed_in? || current_user.id == @dog.user.id
      # hit the database twice to make sure we're allowed to mess with the dog either because we're an admin or because we're the dog's owner
        flash[:danger] = "You can't do that unless you own it."
        redirect_to dogs_path
    end
  end

  def index
      @dogs = current_user.dogs.all
      # instantiate the dogs that belong to the user
  end
 
  def show
  end
  
  def new
    @dog = Dog.new
    # not a puppy, necessarily
  end

  def build
  end

  def create
    
    @dog = current_user.dogs.build(dog_params)
    if @dog.update(breeder: current_user.email)
      # if you add the dog to the website, you'd damned better have been the one to breed it
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
