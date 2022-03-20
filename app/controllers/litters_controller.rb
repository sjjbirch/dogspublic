class LittersController < ApplicationController

  before_action :authenticate_admin!, except: [:gallery]
  before_action :litter_instancer, only: [ :show, :edit,  ]

  # should this be private?
  def litter_params
    params.require(:litter).permit( :identifier, :planned_date, :expected_date,
                                    :actual_date, :expected_size, 
                                    :actual_size, :gallery_image => [] )
  end

  def litter_instancer
    @litter = Litter.find(params[:id])
    # find the litter where id matches our params
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
      flash[:danger] = "Litter creation failed"
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    @litter = Litter.find(params[:id])
    # find the litter where id matches our params
    if @litter.update(litter_params)
      flash[:success] = "#{@litter.identifier} updated"
      redirect_to litters_path
    else
      flash[:danger] = "Update failed"
      render 'edit'
    end
  end

  def destroy
    @littername = Litter.find(params[:id]).identifier
    Litter.find(params[:id]).destroy
    # I don't remember any of this or what I was doing when I did it, nice use of string interpolation though
    flash[:success] = "#{@littername} deleted"
    redirect_to litters_path
  end

  def index
    @litters = Litter.all
  end

  def gallery
    @highlightedlitter = Litter.last(3)
    # SELECT "litters".* FROM "litters" ORDER BY "litters"."id" DESC LIMIT $1  [["LIMIT", 3]]
  end

  def schedule
    # lmao wtf was I thinking here?
    # On the deployed version you can still call this route.
    render 'schedule'
  end

end
