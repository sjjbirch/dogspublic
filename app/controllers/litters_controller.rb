class LittersController < ApplicationController

  before_action :authenticate_admin!, except: [:schedule,:gallery]

  # should this be private?
  def litter_params
    params.require(:litter).permit( :identifier, :planned_date, :expected_date,
                                    :actual_date, :expected_size, 
                                    :actual_size, :gallery_image => [] )
  end

  def new
    @litter = Litter.new
  end

  def create
    @litter = Litter.new(litter_params)
    if @litter.save
      flash[:success] = "Litter created"
      redirect_to litters_path
    else
      flash[:success] = "Litter creation failed"
      render 'new'
    end
  end

  def show
    @litter = Litter.find(params[:id])
  end

  def edit
    @litter = Litter.find(params[:id])
  end

  def update
    @litter = Litter.find(params[:id])
    if @litter.update(litter_params)
      flash[:success] = "#{@litter.identifier} updated"
      redirect_to litters_path
    else
      flash[:failure] = "Update failed"
      render 'edit'
    end
  end

  def destroy
    @littername = Litter.find(params[:id]).identifier
    Litter.find(params[:id]).destroy
    flash[:success] = "#{@littername} deleted"
    redirect_to litters_path
  end

  def index
    @litters = Litter.all
  end

  def gallery
    @highlightedlitter = Litter.last(3)
  end

  def schedule
    # lmao wtf was I thinking here?
    render 'schedule'
  end

end
