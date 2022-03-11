class DogsController < ApplicationController
  def dog_params
    params.require(:dog).permit( :rname, :cname, :dob,
                                    :owner, :handler, 
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
  
  def show
    @dog = Dog.find(params[:id])
  end
  
  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)
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
  end

  def update
  end

  def destroy
  end
end
