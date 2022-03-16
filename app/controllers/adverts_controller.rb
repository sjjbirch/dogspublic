class AdvertsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :ownership_filter, only: [:update, :edit, :destroy]

 def ad_params
    params.require(:advert).permit( :title, :description)
 end

 def ownership_filter
    @advert = Advert.find(params[:id])
    unless current_user.id == @advert.dog.user.id
        flash[:success] = "You can't do that unless you own it."
        redirect_to dogs_path
    end
 end

 def buy
   @advert = Advert.find(params[:id])
   @dog = @advert.dog
   @seller = @dog.user.id
   @buyer = current_user
   Payment.new(buyer_id: @buyer.id, seller_id: @seller, transaction_time: DateTime.now, dogsold: @dog.id ).save

   if @dog.update(user_id: @buyer.id )
      flash[:success] = "Dog Bought"
      redirect_to dogs_path
   else
      flash[:success] = "Dog NOT Bought"
      redirect_to root_path
   end
   # @payment = Payment.new
   # @dog.update(user_id: @buyer)
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

 def index
    @adverts = Advert.all
  end
  

 def show
    @advert = Advert.find(params[:id])
 end

 def edit
 end

 def update
 end

 def destroy
 end

end
