class AdvertsController < ApplicationController
    before_action :god_skip, except: [:index, :show]
    before_action :advert_instancer, only: [:show, :ad_ownership_filter, :buy,
                                             :edit, :destroy ]
    before_action :ad_ownership_filter, only: [:update, :edit, :destroy]

 def index
   @adverts = Advert.order(created_at: :asc)
 end

 def show
 end

 def ad_params
    params.require(:advert).permit( :title, :description)
 end

 def advert_instancer
   @advert = Advert.find(params[:id])
 end

 def ad_ownership_filter
    unless @advert.dog.user.id == current_user.id 
        flash[:success] = "You can't do that unless you own it."
        redirect_to dogs_path
    end
 end

 def buy
   @dog = @advert.dog
   @seller = @dog.user.id
   @buyer = current_user.id

   if @seller == @buyer
      flash[:danger] = "You can't buy your own dog"
      redirect_back(fallback_location: adverts_path)
   else
      if Payment.new(buyer_id: @buyer, seller_id: @seller, transaction_time: DateTime.now, dogsold: @dog.id ).save
         @advert.delete
         @dog.update(user_id: @buyer )
         flash[:success] = "Dog Bought"
         redirect_to dogs_path
      else
         flash[:success] = "Dog NOT Bought"
         redirect_back(fallback_location: adverts_path)
      end
   end
 end

 def new
    @dog = Dog.find(params[:dog_id])
    @advert = Advert.new
 end

 def build
 end

 def create
    @dog = Dog.find(params[:dog_id])
    @advert = @dog.build_advert(ad_params)
    if @advert.save
      flash[:success] = "Dog Advertised"
      redirect_to dogs_path
    else
      # come back to
      flash[:success] = "Advertising failed"
      redirect_to dogs_path
      #   render new_dog_advert_path(dog.id)
    end
 end

  def myads
  @adverts = current_user.adverts
   end

 def edit
 end

 def update
   @advert = Advert.find()
   if @advert.update(ad_params)
     flash[:success] = "Ad updated"
     redirect_to dog_advert_path()
   else
     flash[:success] = "Ad update failed"
     render :edit
   end
 end

 def destroy
   if @advert.destroy
      flash[:success] = "Dog no longer advertised."
      redirect_to '/my_ads'
   else
      flash[:success] = "Advert is still up"
      redirect_to '/my_ads'
   end
 end

end
