class DogsController < ApplicationController
  before_action :admin_signed_in?, only: [:destroy,:edit, :index]
  before_action :user_signed_in?, only: [:build, :usr_destroy, :usr_edit]

  def dog_params
    params.require(:dog).permit(  :user_id, :rname, :cname,
                                  :dob,  :owner, :handler, 
                                  :sex )
  end
  
  def boys
  end

  def girls
  end

  def retired
  end

  def index
    @dogs = Dog.all
  end

  def usr_index
    @dogs = current_user.Dog.all
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

  # as per dog create 
  # but user_id param is inserted by website based on who's logged in
  # def usr_create
  #   @dog = Dog.new(dog_params)
  #   if @dog.save
  #     flash[:success] = "Dog created"
  #     redirect_to dogs_path
  #   else
  #     # come back to
  #     flash[:success] = "Dog creation failed"
  #     render 'new'
  #   end
  # end
  
  def edit
  end

  def update
  end

  def destroy
  end
end
